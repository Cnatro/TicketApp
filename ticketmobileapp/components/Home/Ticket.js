import { useEffect, useState } from "react";
import {
  ScrollView,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
} from "react-native";
import Apis, { authApis, endpoints } from "../../configs/Apis";
import { useNavigation } from "@react-navigation/native";
import useAuth from "../../Hooks/useAuth";
import Spinner from "../Utils/spinner";
import AsyncStorage from "@react-native-async-storage/async-storage";

const Ticket = ({ route }) => {
  const { eventId } = route.params;
  const [user] = useAuth();
  const [eventTypes, setEventTypes] = useState([]);
  const [loading, setLoading] = useState(false);
  const [quantities, setQuantities] = useState({});
  const navigation = useNavigation();

  const loadEventTypes = async () => {
    try {
      setLoading(true);
      let res = await Apis.get(
        `${endpoints["events"]}/${eventId}/event_types/`
      );
      setEventTypes(res.data);
    } catch (error) {
      console.error("Lỗi tải loại vé", error);
    } finally {
      setLoading(false);
    }
  };

  const updateQuantity = (id, delta) => {
    const ticket = eventTypes.find((et) => et.id === id);
    if (!ticket) return;

    const newQuantity = (quantities[id] || 0) + delta;

    if (newQuantity >= 0 && newQuantity <= ticket.quantity) {
      setQuantities((prev) => ({
        ...prev,
        [id]: newQuantity,
      }));
    }
  };
  const totalQuantity = Object.values(quantities).reduce(
    (sum, q) => sum + q,
    0
  );

  const totalPrice = Object.entries(quantities).reduce(
    (sum, [id, quantity]) => {
      const ticket = eventTypes.find((et) => et.id === parseInt(id));
      return ticket ? sum + ticket.price * quantity : sum;
    },
    0
  );

  const onReceipt = async () => {
    try {
      setLoading(true);
      const data = {
        payment_method: "VNPay",
        total_quantity: totalQuantity,
        total_price: totalPrice,
        userId: 1,
        tickets: Object.entries(quantities)
          .filter(([_, qty]) => qty > 0)
          .map(([id, qty]) => ({
            ticket_type_id: parseInt(id),
            quantity: qty,
          })),
      };

      const token = await AsyncStorage.getItem("token");
      let res = await authApis(token).post(`${endpoints["receipt"]}/`, data);

      if (res.status === 201) {
        alert("Thanh toán thành công !!");
        await authApis(token).post(endpoints["send-email"], {
          email: "cnatro23@gmail.com", // chỉnh email đăng nhập
          subject: "Thông báo",
          message: data,
        });
        navigation.navigate("HomeStack", { screen: "Home" });
      }
    } catch (error) {
      console.error("Lỗi thanh toán", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadEventTypes();
  }, []);
  return (
    <>
      {loading && <Spinner />}
      {user !== null ? (
        eventTypes && eventTypes.length > 0 ? (
          <ScrollView contentContainerStyle={styles.container}>
            <Text style={styles.header}>GIỎ HÀNG CỦA BẠN / SHOPPING CART</Text>
            {eventTypes.map((item) => (
              <View key={item.id} style={styles.itemContainer}>
                <Text style={styles.itemName}>
                  Vé {item.name.toUpperCase()}
                </Text>
                <Text style={styles.itemPrice}>
                  {Number(item.price).toLocaleString("vi-VN", {
                    minimumFractionDigits: 2,
                  })}{" "}
                  VNĐ
                </Text>
                {item.quantity >= 0 ? (
                  <View style={styles.counter}>
                    <TouchableOpacity
                      style={styles.buttonMinus}
                      onPress={() => updateQuantity(item.id, -1)}
                    >
                      <Text style={styles.buttonText}>-</Text>
                    </TouchableOpacity>
                    <Text style={styles.quantity}>{quantities[item.id]}</Text>
                    <TouchableOpacity
                      style={styles.buttonPlus}
                      onPress={() => updateQuantity(item.id, 1)}
                    >
                      <Text style={styles.buttonText}>+</Text>
                    </TouchableOpacity>
                  </View>
                ) : (
                  <View style={styles.soldOutBadge}>
                    <Text style={styles.soldOutText}>HẾT VÉ</Text>
                  </View>
                )}
              </View>
            ))}
            <View style={styles.totalContainer}>
              <Text style={styles.totalText}>
                Tổng số lượng: {totalQuantity}
              </Text>
              <Text style={styles.totalText}>
                Tổng tiền:{" "}
                {Number(totalPrice).toLocaleString("vi-VN", {
                  minimumFractionDigits: 2,
                })}{" "}
                VNĐ
              </Text>
            </View>
            <TouchableOpacity
              style={styles.checkoutButton}
              onPress={() =>
                navigation.navigate("PayPal", {
                  totalPrice: totalPrice,
                  onReceipt: onReceipt,
                })
              }
            >
              <Text style={styles.checkoutButtonText}>Thanh toán</Text>
            </TouchableOpacity>
          </ScrollView>
        ) : (
          <View style={styles.container}>
            <Text>Sự kiện không có loại vé</Text>
          </View>
        )
      ) : (
        <View style={styles.loginContainer}>
          <Text style={styles.loginMessage}>Vui lòng đăng nhập để đặt vé</Text>
          <TouchableOpacity
            style={styles.loginButton}
            onPress={() =>
              navigation.navigate("UserStack", { screen: "Login" })
            }
          >
            <Text style={styles.loginButtonText}>Đăng nhập</Text>
          </TouchableOpacity>
        </View>
      )}
    </>
  );
};

export default Ticket;
const styles = StyleSheet.create({
  container: {
    padding: 16,
    backgroundColor: "#fff",
  },
  header: {
    fontSize: 18,
    fontWeight: "bold",
    marginBottom: 16,
    color: "#333",
  },
  itemContainer: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 12,
    borderBottomWidth: 1,
    borderColor: "#eee",
    paddingBottom: 8,
  },
  itemName: {
    flex: 1,
    fontSize: 16,
    fontWeight: "500",
    color: "#333",
  },
  itemPrice: {
    flex: 2,
    fontSize: 14,
    color: "#555",
  },
  counter: {
    flex: 2,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "flex-end",
  },
  buttonMinus: {
    backgroundColor: "#dc3545",
    padding: 10,
    borderRadius: 4,
  },
  buttonPlus: {
    backgroundColor: "#17a2b8",
    padding: 10,
    borderRadius: 4,
  },
  buttonText: {
    color: "#fff",
    fontSize: 18,
    fontWeight: "bold",
  },
  quantity: {
    marginHorizontal: 10,
    fontSize: 16,
    fontWeight: "500",
  },
  loginContainer: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    padding: 20,
    backgroundColor: "#f9f9f9",
    borderRadius: 8,
    margin: 16,
  },
  loginMessage: {
    fontSize: 18,
    color: "#333",
    marginBottom: 12,
    fontWeight: "600",
    textAlign: "center",
  },
  loginButton: {
    backgroundColor: "#007bff",
    paddingVertical: 10,
    paddingHorizontal: 30,
    borderRadius: 25,
    elevation: 2,
  },
  loginButtonText: {
    color: "#fff",
    fontWeight: "700",
    fontSize: 16,
  },
  checkoutButton: {
    marginTop: 24,
    backgroundColor: "#28a745",
    paddingVertical: 14,
    borderRadius: 30,
    alignItems: "center",
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 3,
    elevation: 5,
  },
  checkoutButtonText: {
    color: "#fff",
    fontSize: 14,
    fontWeight: "bold",
    textTransform: "uppercase",
    letterSpacing: 1,
  },
  totalContainer: {
    marginTop: 20,
    padding: 16,
    backgroundColor: "#f1f1f1",
    borderRadius: 8,
  },
  totalText: {
    fontSize: 16,
    fontWeight: "bold",
    color: "#333",
    marginBottom: 6,
  },
  soldOutBadge: {
    backgroundColor: "#dc3545",
    paddingVertical: 6,
    paddingHorizontal: 12,
    borderRadius: 20,
    alignSelf: "flex-end",
  },

  soldOutText: {
    color: "#fff",
    fontWeight: "bold",
    fontSize: 12,
    textTransform: "uppercase",
  },
});
