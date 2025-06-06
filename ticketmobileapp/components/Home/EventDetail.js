import { useEffect, useRef, useState } from "react";
import {
  Image,
  ScrollView,
  StyleSheet,
  Text,
  View,
  Dimensions,
  TouchableOpacity,
} from "react-native";
import { LinearGradient } from "expo-linear-gradient";
import { Ionicons } from "@expo/vector-icons";
import Apis, { endpoints } from "../../configs/Apis";
import Spinner from "../Utils/spinner";
import { useNavigation } from "@react-navigation/native";
import { WebView } from 'react-native-webview';
const { width } = Dimensions.get("window");


const EventDetail = ({ route }) => {
  const { eventId } = route.params;
  const [eventDetail, setEventDetail] = useState({});
  const [loading, setLoading] = useState(false);
  const scrollViewRef = useRef(null);
  const buttonRef = useRef(null);
  const [showFixedButton, setShowFixedButton] = useState(true);
  const navigation = useNavigation();

  const loadEventDetail = async () => {
    try {
      setLoading(true);
      let res = await Apis.get(`${endpoints["events"]}/${eventId}`);
      setEventDetail(res.data);
      //   console.log(res.data);
    } catch (error) {
      console.error("Lỗi tải chi tiết sự kiện", error);
    } finally {
      setLoading(false);
    }
  };

  const handleScroll = (event) => {
    const scrollY = event.nativeEvent.contentOffset.y;

    if (buttonRef.current) {
      buttonRef.current.measure((x, y, width, height, pageX, pageY) => {
        const windowHeight = Dimensions.get("window").height;
        if (scrollY + windowHeight >= pageY - 50) {
          setShowFixedButton(false);
        } else {
          setShowFixedButton(true);
        }
      });
    }
  };

  const getStatusColor = (status) => {
    switch (status?.toLowerCase()) {
      case "ongoing":
      case "đang diễn ra":
        return "#10B981";
      case "ended":
      case "đã kết thúc":
        return "#6B7280";
      case "published":
      case "đã công bố":
        return "#F59E0B";
      case "cancelled":
      case "đã hủy":
        return "#EF4444";
      default:
        return "#6366F1";
    }
  };
  const translateStatus = (status) => {
    switch (status) {
      case "published":
        return "Sắp diễn ra";
      case "ongoing":
        return "Đang diễn ra";
      case "ended":
        return "Đã kết thúc";
      case "cancelled":
        return "Đã hủy";
      default:
        return "Không xác định";
    }
  };

  useEffect(() => {
    loadEventDetail();
  }, []);

  return (
    <>
      <ScrollView
        ref={scrollViewRef}
        style={styles.container}
        showsVerticalScrollIndicator={false}
        onScroll={handleScroll}
        scrollEventThrottle={16}
      >
        {loading && <Spinner />}
        <View style={styles.heroContainer}>
          <Image source={{ uri: eventDetail.image }} style={styles.heroImage} />
          <LinearGradient
            colors={["transparent", "rgba(0,0,0,0.7)"]}
            style={styles.heroGradient}
          />
          <View style={styles.heroContent}>
            <Text style={styles.heroTitle}>{eventDetail.name}</Text>
          </View>
        </View>

        <View style={styles.contentContainer}>
          {/* Trạng thái */}
          <View
            style={[
              styles.statusBadge,
              { backgroundColor: getStatusColor(eventDetail.status) },
            ]}
          >
            <Text style={styles.statusText}>
              {translateStatus(eventDetail.status)}
            </Text>
          </View>

          {/* Card thông tin chi tiết */}
          <View style={styles.card}>
            <View style={styles.cardHeader}>
              <Ionicons
                name="information-circle-outline"
                size={20}
                color="#0EA5E9"
              />
              <Text style={styles.cardTitle}>Thông tin chi tiết</Text>
            </View>

            {/* Số vé */}
            <View style={styles.innerSection}>
              <View style={styles.innerHeader}>
                <Ionicons name="people" size={20} color="#8B5CF6" />
                <Text style={styles.innerTitle}>Số vé: </Text>
                <Text style={styles.categoryName}>
                  {eventDetail.attendee_count?.toLocaleString("vi-VN")} vé đăng
                  kí
                </Text>
              </View>
            </View>

            {/* Thời gian */}
            <View style={styles.innerSection}>
              <View style={styles.innerHeader}>
                <Ionicons name="time-outline" size={18} color="#10B981" />
                <Text style={styles.innerTitle}>Thời gian</Text>
              </View>
              <View style={styles.timeContainer}>
                <View style={styles.timeItem}>
                  <Text style={styles.timeLabel}>Bắt đầu</Text>
                  <Text style={styles.timeValue}>
                    {new Date(eventDetail.started_date).toLocaleString("vi-VN")}
                  </Text>
                </View>
                <View style={styles.timeDivider} />
                <View style={styles.timeItem}>
                  <Text style={styles.timeLabel}>Kết thúc</Text>
                  <Text style={styles.timeValue}>
                    {new Date(eventDetail.ended_date).toLocaleString("vi-VN")}
                  </Text>
                </View>
              </View>
            </View>

            {/* Thể loại */}
            {eventDetail.category && (
              <View style={styles.innerSection}>
                <View style={styles.innerHeader}>
                  <Ionicons name="pricetag-outline" size={18} color="#F59E0B" />
                  <Text style={styles.innerTitle}>Thể loại: </Text>
                  <Text style={styles.categoryName}>
                    {eventDetail.category.name}
                  </Text>
                </View>
              </View>
            )}

            {/* Địa điểm */}
            {eventDetail.venue && (
              <View style={styles.innerSection}>
                <View style={styles.innerHeader}>
                  <Ionicons name="location-outline" size={18} color="#EF4444" />
                  <Text style={styles.innerTitle}>Địa điểm: </Text>
                </View>
                <View style={styles.venueRow}>
                  <Text style={styles.venueName}>
                    {eventDetail.venue.name},{" "}
                  </Text>
                  <Text style={styles.venueAddress}>
                    {eventDetail.venue.address}
                  </Text>
                </View>
                {/* Bản đồ */}
                {eventDetail.venue.latitude && eventDetail.venue.longitude ? (
                  <View style={{ height: 300, borderRadius: 10, overflow: 'hidden', marginTop: 10 }}>
                    <WebView
                      source={{
                        html: `
          <!DOCTYPE html>
          <html>
          <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>html, body, #map { height: 100%; margin: 0; padding: 0; }</style>
            <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
            <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
          </head>
          <body>
            <div id="map"></div>
            <script>
              var map = L.map('map').setView([${eventDetail.venue.latitude}, ${eventDetail.venue.longitude}], 14);
              L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                maxZoom: 19,
                attribution: '© OpenStreetMap'
              }).addTo(map);
              L.marker([${eventDetail.venue.latitude}, ${eventDetail.venue.longitude}])
                .addTo(map)
                .bindPopup('${eventDetail.venue.name}')
                .openPopup();
            </script>
          </body>
          </html>
        `
                      }}
                      originWhitelist={['*']}
                      javaScriptEnabled={true}
                      domStorageEnabled={true}
                    />
                  </View>
                ) : (
                  <Text style={styles.warningText}>Không có tọa độ cho địa điểm này</Text>
                )}
                <View>
                  {eventDetail.ticket_types && eventDetail.ticket_types.length > 0 && (
                    <>
                      <View style={styles.cardHeader}>
                        <Ionicons
                          name="cash-outline"
                          size={20}
                          color="#10B981"
                        />
                        <Text style={styles.cardTitle}>Giá vé</Text>
                      </View>
                      <View style={styles.ticketList}>
                        {eventDetail.ticket_types.map((item) => (
                          <View key={item.id} style={styles.ticketItem}>
                            <Text style={styles.ticketName}>
                              + Vé {item.name}
                            </Text>
                            <Text style={styles.ticketPrice}>
                              {Number(item.price).toLocaleString("vi-VN", {
                                minimumFractionDigits: 2,
                              })}{" "}
                              VNĐ
                            </Text>
                          </View>
                        ))}
                      </View>
                    </>
                  )}
                  <Text style={[{ paddingTop: "10px" }, styles.venueName]}>
                    Sơ đồ chỗ ngồi:{" "}
                  </Text>
                  {eventDetail.venue.img_seat && (
                    <Image
                      source={{ uri: eventDetail.venue.img_seat }}
                      style={styles.venueImage}
                    />
                  )}
                </View>
              </View>
            )}

            {/* Chương trình sự kiện */}
            {eventDetail.performances &&
              eventDetail.performances.length > 0 && (
                <View>
                  <View style={styles.cardHeader}>
                    <Ionicons name="list-outline" size={20} color="#3B82F6" />
                    <Text style={styles.cardTitle}>Chương trình sự kiện</Text>
                  </View>
                  {eventDetail.performances.map((item) => (
                    <View key={item.id} style={styles.performanceItem}>
                      {/* <Ionicons name="calendar-outline" size={20} color="#3B82F6" /> */}
                      <Text style={styles.performanceName}>- {item.name}</Text>
                      <Text style={styles.performanceTime}>
                        {new Date(item.started_date).toLocaleString("vi-VN", {
                          hour12: false,
                        })}{" "}
                        -{" "}
                        {new Date(item.ended_date).toLocaleString("vi-VN", {
                          hour12: false,
                        })}
                      </Text>
                    </View>
                  ))}
                </View>
              )}
            {/* Mô tả */}
            <View style={styles.cardHeader}>
              <Ionicons
                name="document-text-outline"
                size={20}
                color="#6366F1"
              />
              <Text style={styles.cardTitle}>Mô tả</Text>
            </View>
            <Text style={styles.description}>{eventDetail.description}</Text>
          </View>
          <View ref={buttonRef} style={{ marginTop: 20, alignItems: "center" }}>
            <TouchableOpacity
              style={styles.realBuyButton}
              onPress={() =>
                navigation.navigate("Ticket", { eventId: eventId })
              }
            >
              <Text style={{ color: "#fff", fontWeight: "bold" }}>
                Mua hàng
              </Text>
            </TouchableOpacity>
          </View>
        </View>
      </ScrollView>
      {showFixedButton && (
        <View style={styles.fixedBuyButton}>
          <TouchableOpacity
            style={styles.realBuyButton}
            onPress={() => navigation.navigate("Ticket", { eventId: eventId })}
          >
            <Text style={{ color: "#fff", fontWeight: "bold" }}>Mua hàng</Text>
          </TouchableOpacity>
        </View>
      )}
    </>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#F9FAFB",
  },
  heroContainer: {
    position: "relative",
    height: 420,
  },
  heroImage: {
    width: "100%",
    height: "100%",
    resizeMode: "cover",
  },
  heroGradient: {
    position: "absolute",
    bottom: 0,
    left: 0,
    right: 0,
    height: 120,
  },
  heroContent: {
    position: "absolute",
    bottom: 24,
    left: 20,
    right: 20,
  },
  heroTitle: {
    fontSize: 28,
    fontWeight: "700",
    color: "#FFF",
    lineHeight: 36,
    textShadowColor: "rgba(0,0,0,0.6)",
    textShadowOffset: { width: 0, height: 3 },
    textShadowRadius: 5,
  },
  contentContainer: {
    paddingHorizontal: 20,
    paddingTop: 20,
    paddingBottom: 40,
  },
  statusBadge: {
    alignSelf: "flex-start",
    // backgroundColor: "#10B981",
    paddingHorizontal: 14,
    paddingVertical: 8,
    borderRadius: 20,
    marginBottom: 20,
  },
  statusText: {
    color: "#FFFFFF",
    fontSize: 13,
    fontWeight: "700",
    textTransform: "uppercase",
    letterSpacing: 1,
  },
  card: {
    backgroundColor: "#FFFFFF",
    borderRadius: 16,
    padding: 20,
    marginBottom: 20,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 6,
    elevation: 4,
  },
  cardHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 14,
  },
  cardTitle: {
    fontSize: 18,
    fontWeight: "700",
    color: "#111827",
    marginLeft: 10,
  },
  description: {
    fontSize: 15,
    lineHeight: 24,
    color: "#4B5563",
  },
  timeContainer: {
    flexDirection: "row",
    justifyContent: "space-between",
    gap: 16,
    marginBottom: 5,
  },
  timeItem: {
    flex: 1,
  },
  timeLabel: {
    fontSize: 12,
    fontWeight: "700",
    color: "#9CA3AF",
    textTransform: "uppercase",
    marginBottom: 6,
  },
  timeValue: {
    fontSize: 15,
    fontWeight: "600",
    color: "#1F2937",
  },
  timeDivider: {
    width: 1,
    backgroundColor: "#E5E7EB",
    marginHorizontal: 12,
  },
  categoryName: {
    fontSize: 16,
    fontWeight: "600",
    color: "#1F2937",
    marginLeft: 6,
  },
  venueRow: {
    flexDirection: "row",
    marginLeft: 26,
    flexWrap: "wrap",
  },
  venueName: {
    fontSize: 17,
    fontWeight: "700",
    color: "#111827",
  },
  venueAddress: {
    fontSize: 17,
    color: "#6B7280",
  },
  venueImage: {
    width: "100%",
    height: 160,
    borderRadius: 12,
    marginTop: 14,
    backgroundColor: "#F3F4F6",
  },
  innerSection: {
    marginBottom: 10,
  },
  innerHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 5,
  },
  innerTitle: {
    fontSize: 16,
    fontWeight: "700",
    marginLeft: 8,
    color: "#374151",
  },
  performanceItem: {
    marginBottom: 12,
    borderBottomWidth: 1,
    borderBottomColor: "#E5E7EB",
    paddingBottom: 8,
  },
  performanceName: {
    fontSize: 16,
    fontWeight: "600",
    color: "#111827",
  },
  performanceTime: {
    fontSize: 14,
    color: "#6B7280",
    marginTop: 2,
  },
  ticketList: {
    marginBottom: 16,
    marginLeft: 10,
  },
  ticketItem: {
    flexDirection: "row",
    justifyContent: "space-between",
    paddingVertical: 8,
    borderBottomWidth: 1,
    borderBottomColor: "#E5E7EB",
  },
  ticketName: {
    fontSize: 16,
    color: "#374151",
    fontWeight: "600",
  },
  ticketPrice: {
    fontSize: 16,
    color: "#10B981",
    fontWeight: "700",
  },
  fixedBuyButton: {
    position: "absolute",
    bottom: 0,
    left: 0,
    right: 0,
    alignItems: "center",
    zIndex: 1000,
    backgroundColor: "#fff",
    paddingVertical: 10,
  },
  realBuyButton: {
    backgroundColor: "#F59E0B",
    paddingVertical: 14,
    paddingHorizontal: 40,
    borderRadius: 30,
  },
  mapContainer: {
    width: '100%',
    height: 200,
    borderRadius: 12,
    overflow: 'hidden',
    marginTop: 14,
    marginBottom: 14,
  },
  map: {
    flex: 1,
  },
  calloutContainer: {
    width: 150,
    padding: 10,
    backgroundColor: '#fff',
    borderRadius: 8,
  },
  calloutTitle: {
    fontSize: 14,
    fontWeight: 'bold',
    marginBottom: 5,
  },
  calloutDescription: {
    fontSize: 12,
    color: '#666',
  },
  warningText: {
    fontSize: 14,
    color: '#EF4444',
    marginTop: 10,
    marginLeft: 26,
  },
});

export default EventDetail;
