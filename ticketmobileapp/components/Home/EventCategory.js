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
import { useNavigation } from "@react-navigation/native";
import Spinner from "../Utils/spinner";

const { width } = Dimensions.get("window");
const ITEM_SPACING = 10; // khoảng cách giữa các item và lề
const NUM_COLUMNS = 2;
const itemWidth = (width - ITEM_SPACING * (NUM_COLUMNS + 1)) / NUM_COLUMNS;

const EventCategory = ({ route }) => {
    const [events, setEvents] = useState([]);
    const [loading, setLoading] = useState(false);
    const navigation = useNavigation();
    const categoryId = route.params.categoryId;
    const categoryName = route.params.categoryName;


    const loadEvent = async () => {
        try {
            setLoading(true);
            let res = await Apis.get(`${endpoints["categories"]}/${categoryId}/events/`);
            setEvents(res.data);
        } catch (error) {
            console.error("Lỗi khi tải sự kiện:", error);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        loadEvent();
        navigation.setOptions({ title: categoryName });
    }, []);

    return (
        <View style={styles.container}>
            {loading && <Spinner />}
            {events.length === 0 ? (
                <Text style={styles.emptyText}>Không có sự kiện nào</Text>
            ) : (
                <View style={styles.gridContainer}>
                    {events.map((item, index) => (
                        <TouchableOpacity
                            key={item.id}
                            onPress={() =>
                                navigation.navigate("EventDetail", { eventId: item.id })
                            }
                        >
                            <View
                                style={[
                                    styles.eventItem,
                                    {
                                        marginRight:
                                            (index + 1) % NUM_COLUMNS === 0 ? 0 : ITEM_SPACING,
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
                    ))}
                </View>
            )}
        </View>
    );
};

const styles = StyleSheet.create({
    gridContainer: {
        flexDirection: "row",
        flexWrap: "wrap",
        paddingLeft: ITEM_SPACING,
        paddingTop: ITEM_SPACING,
    },
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

export default EventCategory;
