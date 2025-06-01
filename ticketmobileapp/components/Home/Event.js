import {
  Image,
  StyleSheet,
  Text,
  View,
  FlatList,
  Dimensions,
  TouchableOpacity,
} from "react-native";
import { useEffect, useState } from "react";
import Apis, { endpoints } from "../../configs/Apis";

const { width } = Dimensions.get("window");
const ITEM_SPACING = 10; // khoảng cách giữa các item và lề
const NUM_COLUMNS = 2;
const itemWidth = (width - ITEM_SPACING * (NUM_COLUMNS + 1)) / NUM_COLUMNS;

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

  const renderEventItem = ({ item, index }) => (
    <TouchableOpacity>
      <View
        style={[
          styles.eventItem,
          {
            marginRight: (index + 1) % NUM_COLUMNS === 0 ? 0 : ITEM_SPACING,
          },
        ]}
      >
        <Image source={{ uri: item.image }} style={styles.eventImage} />
        <View style={styles.eventInfo}>
          <Text style={styles.eventName} numberOfLines={2}>
            {item.name}
          </Text>
          <Text style={styles.eventDate}>
            Bắt đầu: {new Date(item.started_date).toLocaleDateString()}
          </Text>
          <Text style={styles.eventVenue} numberOfLines={1}>
            Địa điểm: {item.venue_name}
          </Text>
        </View>
      </View>
    </TouchableOpacity>
  );

  return (
    <View style={styles.container}>
      {events.length === 0 ? (
        <Text style={styles.emptyText}>Không có sự kiện nào</Text>
      ) : (
        <FlatList
          data={events}
          renderItem={renderEventItem}
          keyExtractor={(item) => item.id.toString()}
          numColumns={NUM_COLUMNS}
          showsVerticalScrollIndicator={false}
          contentContainerStyle={styles.listContent}
        />
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#f5f5f5",
    borderRadius: 10,
  },
  listContent: {
    paddingTop: 10,
    paddingBottom: 10,
    paddingLeft: ITEM_SPACING,
  },
  emptyText: {
    textAlign: "center",
    marginTop: 20,
    fontSize: 16,
    color: "#999",
  },
  eventItem: {
    backgroundColor: "#ffffff",
    borderRadius: 12,
    marginBottom: ITEM_SPACING,
    width: itemWidth - 15,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
    overflow: "hidden",
  },
  eventImage: {
    width: "100%",
    height: itemWidth,
  },
  eventInfo: {
    paddingHorizontal: 10,
    paddingVertical: 8,
  },
  eventName: {
    fontSize: 14,
    fontWeight: "600",
    color: "#1a202c",
    marginBottom: 4,
  },
  eventVenue: {
    fontSize: 12,
    color: "#4a5568",
  },
  eventDate: {
    fontSize: 13,
    color: "#4a5568",
    marginBottom: 4,
  },
});

export default Event;
