import {
  View,
  FlatList,
  Text,
  StyleSheet,
  TouchableOpacity,
  Image,
  Dimensions,
} from "react-native";
import { useNavigation } from "@react-navigation/native";
import Spinner from "../Utils/spinner";

const { width } = Dimensions.get("window");
const ITEM_SPACING = 10;
const NUM_COLUMNS = 2;
const itemWidth = (width - ITEM_SPACING * (NUM_COLUMNS + 1)) / NUM_COLUMNS;

const Event = ({ events, page, loading, loadMore }) => {
  const navigation = useNavigation();

  const renderItem = ({ item, index }) => (
    <TouchableOpacity
      onPress={() => navigation.navigate("EventDetail", { eventId: item.id })}
    >
      <View
        style={[
          styles.eventItem,
          { marginRight: (index + 1) % NUM_COLUMNS === 0 ? 0 : ITEM_SPACING },
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
      {events && events.length > 0 ? (
        <FlatList
          data={events}
          renderItem={renderItem}
          keyExtractor={(item) => item.id.toString()}
          numColumns={NUM_COLUMNS}
          contentContainerStyle={styles.gridContainer}
          onEndReached={loadMore}
          onEndReachedThreshold={0.5}
          ListFooterComponent={loading && page > 1 ? <Spinner /> : null}
        />
      ) : (
        <Text style={styles.emptyText}>Không có sự kiện nào</Text>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    backgroundColor: "#f5f5f5",
    borderRadius: 10,
    marginBottom: 30,
    flex: 1,
  },
  gridContainer: {
    justifyContent: "center",
    alignItems: "center",
    paddingLeft: ITEM_SPACING,
    paddingTop: ITEM_SPACING,
  },
  emptyText: {
    textAlign: "center",
    marginTop: 20,
    fontSize: 16,
    color: "#999",
  },
  eventItem: {
    backgroundColor: "#fff",
    borderRadius: 12,
    marginBottom: ITEM_SPACING,
    width: itemWidth,
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
