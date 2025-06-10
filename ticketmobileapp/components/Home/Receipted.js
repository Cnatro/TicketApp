import AsyncStorage from "@react-native-async-storage/async-storage";
import React, { useEffect, useState } from "react";
import {
  View,
  Text,
  StyleSheet,
  FlatList,
  TouchableOpacity,
  ScrollView,
} from "react-native";
import QRCode from "react-native-qrcode-svg";
import { authApis, endpoints } from "../../configs/Apis";
import Spinner from "../Utils/spinner";

const Receipted = () => {
  const [receiptLatest, setReceiptLatest] = useState([]);
  const [loading, setLoading] = useState(false);
  const loadReceipt = async () => {
    try {
      setLoading(true);

      const token = await AsyncStorage.getItem("token");
      let res = await authApis(token).get(`${endpoints["receipt"]}/latest/`);
      if (res.status === 200) setReceiptLatest(res.data);
    } catch (error) {
      console.error("Lỗi load vé đã mua", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadReceipt();
  }, []);

  return (
    <>
      {receiptLatest && receiptLatest.length > 0 ? (
        <ScrollView
          style={styles.scrollView}
          contentContainerStyle={styles.scrollContent}
        >
          {receiptLatest.map((receipt) => (
            <View style={styles.container} key={receipt.id}>
              {loading && <Spinner />}
              <Text style={styles.header}>🧾 Hóa đơn #{receipt.id}</Text>
              <View style={styles.infoBlock}>
                <Text style={styles.label}>Phương thức thanh toán:</Text>
                <Text style={styles.value}>{receipt.payment_method}</Text>
              </View>
              <View style={styles.infoBlock}>
                <Text style={styles.label}>Tổng số lượng:</Text>
                <Text style={styles.value}>{receipt.total_quantity}</Text>
              </View>
              <View style={styles.infoBlock}>
                <Text style={styles.label}>Tổng tiền:</Text>
                <Text style={styles.value}>
                  {Number(receipt.total_price).toLocaleString()} VNĐ
                </Text>
              </View>
              <Text style={styles.ticketListTitle}>🎟 Danh sách vé:</Text>
              <FlatList
                data={receipt.tickets}
                keyExtractor={(item) => item.id.toString()}
                renderItem={({ item }) => <TicketItem ticket={item} />}
                contentContainerStyle={{ paddingBottom: 40 }}
                scrollEnabled={false}
              />
            </View>
          ))}
        </ScrollView>
      ) : (
        <View style={styles.container}>
          <Text style={styles.noReceiptText}>
            Bạn chưa có giao dịch nào trên ZiveGO
          </Text>
        </View>
      )}
    </>
  );
};

const TicketItem = ({ ticket }) => {
  const [showQR, setShowQR] = useState(false);

  return (
    <View style={styles.ticketContainer}>
      <Text style={styles.eventName}>🎫 {ticket.event_name}</Text>
      <View style={styles.infoRow}>
        <Text style={styles.label}>Số lượng:</Text>
        <Text style={styles.value}>{ticket.quantity}</Text>
      </View>
      <View style={styles.infoRow}>
        <Text style={styles.label}>Check-in:</Text>
        <Text
          style={[
            styles.value,
            { color: ticket.is_checked_in ? "#28a745" : "#dc3545" },
          ]}
        >
          {ticket.is_checked_in ? "Đã check-in ✅" : "Chưa check-in ❌"}
        </Text>
      </View>

      <TouchableOpacity
        onPress={() => setShowQR(!showQR)}
        style={styles.button}
      >
        <Text style={styles.buttonText}>
          {showQR ? "Ẩn mã QR" : "Xem mã QR"}
        </Text>
      </TouchableOpacity>

      {showQR && (
        <View style={styles.qrBox}>
          <QRCode
            value={ticket.code_qr}
            size={180}
            color="#222"
            backgroundColor="#fff"
          />
          <ScrollView style={styles.qrTextBox}>
            <Text style={styles.qrRawText}>{ticket.code_qr}</Text>
          </ScrollView>
        </View>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingHorizontal: 20,
    paddingTop: 20,
    backgroundColor: "#f9fafb",
    borderBottomWidth: 1,
    borderBottomColor: "#e5e7eb",
  },
  header: {
    fontSize: 26,
    fontWeight: "700",
    color: "#1f2937",
    marginBottom: 20,
  },
  infoBlock: {
    flexDirection: "row",
    marginBottom: 8,
  },
  label: {
    fontWeight: "600",
    color: "#6b7280",
    flex: 1,
  },
  value: {
    flex: 1,
    fontWeight: "500",
    color: "#111827",
    textAlign: "right",
  },
  ticketListTitle: {
    marginTop: 30,
    fontSize: 20,
    fontWeight: "700",
    color: "#111827",
    marginBottom: 12,
  },
  ticketContainer: {
    backgroundColor: "#fff",
    borderRadius: 14,
    padding: 20,
    marginBottom: 16,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.1,
    shadowRadius: 12,
    elevation: 6,
  },
  eventName: {
    fontSize: 18,
    fontWeight: "700",
    color: "#2563eb",
    marginBottom: 12,
  },
  infoRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    marginBottom: 6,
  },
  button: {
    marginTop: 16,
    backgroundColor: "#2563eb",
    paddingVertical: 12,
    borderRadius: 10,
    alignItems: "center",
    shadowColor: "#2563eb",
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.3,
    shadowRadius: 10,
    elevation: 4,
  },
  buttonText: {
    color: "#fff",
    fontWeight: "700",
    fontSize: 16,
  },
  qrBox: {
    marginTop: 16,
    alignItems: "center",
    backgroundColor: "#f3f4f6",
    padding: 16,
    borderRadius: 14,
  },
  qrTextBox: {
    marginTop: 14,
    maxHeight: 100,
    paddingHorizontal: 10,
  },
  qrRawText: {
    fontFamily: "monospace",
    color: "#4b5563",
    fontSize: 10,
    textAlign: "center",
  },
  noReceiptText: {
    fontSize: 18,
    fontWeight: "600",
    color: "#6b7280",
    textAlign: "center",
  },
  scrollView: {
    flex: 1,
    backgroundColor: "#f9fafb",
  },
  scrollContent: {
    padding: 5,
    paddingBottom: 80,
  },
});

export default Receipted;
