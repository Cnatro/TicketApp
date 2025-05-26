import { Image, StyleSheet, Text, View } from "react-native";
import { useEffect, useState } from "react";
import Apis, { endpoints } from "../../configs/Apis";

const Event = () => {
  const [events, setEvents] = useState([]);

  const loadEvent = async () => {
    try {
      let res = await Apis.get(endpoints["events"]);
      setEvents(res.data);
    } catch (error) {
      console.error("Lỗi khi tải sự kiện:", error);
    }
  };

  useEffect(() => {
    loadEvent();
  }, []);

  return (
    <View style={styles.container}>
      {events.length === 0 ? (
        <Text style={styles.emptyText}>Không có sự kiện nào</Text>
      ) : (
        events.map((item) => (
          <View key={item.id} style={styles.eventItem}>
            <Image source={{ uri: item.image }} style={styles.eventImage} />
            <View style={styles.eventInfo}>
              <Text style={styles.eventName}>{item.name}</Text>
              <Text style={styles.eventCategory}>{item.category_name}</Text>
              <Text style={styles.eventDate}>
                Bắt đầu: {new Date(item.started_date).toLocaleDateString()}
              </Text>
              <Text style={styles.eventVenue}>Địa điểm: {item.venue_name}</Text>
              <Text style={styles.eventAttendees}>
                Số người tham gia: {item.attendee_count}
              </Text>
            </View>
          </View>
        ))
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    paddingHorizontal: 10,
  },
  emptyText: {
    textAlign: "center",
    marginTop: 20,
    fontSize: 16,
    color: "#999",
  },
  eventItem: {
    flexDirection: "row",
    backgroundColor: "#f9f9f9",
    borderRadius: 12,
    padding: 10,
    marginBottom: 12,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  eventImage: {
    width: 100,
    height: 100,
    borderRadius: 8,
    marginRight: 12,
  },
  eventInfo: {
    flex: 1,
    justifyContent: "space-between",
  },
  eventName: {
    fontSize: 16,
    fontWeight: "bold",
    color: "#1c3f94",
    marginBottom: 4,
  },
  eventCategory: {
    fontSize: 14,
    color: "#f89c1c",
    marginBottom: 4,
  },
  eventDate: {
    fontSize: 12,
    color: "#555",
  },
  eventVenue: {
    fontSize: 12,
    color: "#555",
  },
  eventAttendees: {
    fontSize: 12,
    color: "#888",
  },
});

export default Event;
