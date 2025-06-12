import AsyncStorage from "@react-native-async-storage/async-storage";
import { useEffect, useState } from "react";
import {
    View,
    Text,
    StyleSheet,
    FlatList,
    TouchableOpacity,
} from "react-native";
import { authApis, endpoints } from "../../configs/Apis";
import Spinner from "../Utils/spinner";
import { TextInput } from "react-native-paper";

const Review = () => {
    const [events, setEvents] = useState([]);
    const [loading, setLoading] = useState(false);
    const [rating, setRating] = useState(0);
    const [comment, setComment] = useState("");
    const [selectedEvent, setSelectedEvent] = useState("");
    const [submit, setSubmit] = useState(false);

    const loadEvent = async () => {
        try {
            setLoading(true);
            const token = await AsyncStorage.getItem("token");
            let res = await authApis(token).get(`${endpoints["events"]}/end-events`);
            setEvents(res.data);
        } catch (error) {
            console.error("Lỗi load sự kiện", error);
        } finally {
            setLoading(false);
        }
    };

    const handleReview = (event) => {
        setSelectedEvent(event);
        setComment("");
        setRating(0);
    }

    const submitReview = async () => {
        try {
            setSubmit(true);
            const token = await AsyncStorage.getItem("token");
            await authApis(token).post(`${endpoints['events']}/${selectedEvent.id}/comment/`, {
                content: comment
            })

            await authApis(token).post(`${endpoints['events']}/${selectedEvent.id}/review/`, {
                count: rating
            })
            alert("Đánh giá thành công!");
            setSelectedEvent(null);// ẩn form
            loadEvent();
        } catch (error) {
            console.error("Lỗi gửi đánh giá");
            alert("Gửi đánh giá thất bại.");
        } finally {
            setSubmit(false);
        }
    }



    useEffect(() => {
        loadEvent();
    }, []);

    const renderItem = ({ item }) => (
        <View style={styles.row}>
            <Text style={styles.cellLeft} numberOfLines={1}>{item.name}</Text>

            <View style={styles.cellMiddleAddress}>
                <Text style={styles.venueName} numberOfLines={1}>{item.venue_name}</Text>
                <Text style={styles.time} numberOfLines={1}>{item.started_date}</Text>
            </View>

            <View style={styles.cellRight}>
                {item.is_reviewed ? (
                    <TouchableOpacity style={[styles.button, styles.buttonDisabled]} disabled={true}>
                        <Text style={styles.buttonTextDisabled}>Đã đánh giá</Text>
                    </TouchableOpacity>
                ) : (
                    <TouchableOpacity style={styles.button} onPress={() => handleReview(item)}>
                        <Text style={styles.buttonText}>Đánh giá</Text>
                    </TouchableOpacity>
                )}
            </View>
        </View>
    );

    return (
        <View style={styles.container}>
            {loading && <Spinner />}
            {events && events.length > 0 ? (
                <>
                    <View style={styles.headerRow}>
                        <Text style={styles.headerCellLeft}>Sự kiện</Text>
                        <Text style={styles.headerCellMiddle}></Text>
                        <Text style={styles.headerCellRight}></Text>
                    </View>
                    <FlatList
                        scrollEnabled={false}
                        data={events}
                        keyExtractor={item => item.id.toString()}
                        renderItem={renderItem}
                        contentContainerStyle={{ paddingBottom: 20 }}
                    />
                </>
            ) : (
                <Text style={{ padding: 16 }}>Không có sự kiện nào để đánh giá</Text>
            )}
            {selectedEvent && (
                <View style={styles.reviewForm}>
                    <Text style={styles.reviewTitle}>Đánh giá sự kiện: {selectedEvent.name}</Text>
                    <Text>Chọn sao:</Text>
                    <View style={styles.starsRow}>
                        {[1, 2, 3, 4, 5].map(i => (
                            <Text
                                key={i}
                                onPress={() => setRating(i)}
                                style={{ fontSize: 24, color: i <= rating ? '#FFD700' : '#ccc' }}
                            >★</Text>
                        ))}
                    </View>
                    <Text>Nội dung:</Text>
                    <TextInput
                        style={styles.textInput}
                        value={comment}
                        onChangeText={setComment}
                        placeholder="Nhập bình luận..."
                        multiline
                    />

                    <View style={{ flexDirection: "row", marginTop: 8 }}>
                        <TouchableOpacity onPress={() => setSelectedEvent(null)} style={[styles.button, { backgroundColor: "#ccc", marginRight: 8 }]}>
                            <Text>Hủy</Text>
                        </TouchableOpacity>
                        <TouchableOpacity
                            onPress={submitReview}
                            style={styles.button}
                            disabled={submit || rating === 0 || comment.trim() === ""}
                        >
                            <Text style={{ color: "#fff" }}>
                                {submit ? "Đang gửi..." : "Gửi đánh giá"}
                            </Text>
                        </TouchableOpacity>
                    </View>
                </View>

            )}
        </View>

    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#fff',
        paddingHorizontal: 16,
        paddingTop: 16,
    },
    headerRow: {
        flexDirection: 'row',
        paddingBottom: 8,
        borderBottomWidth: 1,
        borderColor: '#ddd',
    },
    headerCellLeft: {
        flex: 1.2,
        fontWeight: 'bold',
        color: '#000',
    },
    headerCellMiddle: {
        flex: 1.5,
        fontWeight: 'bold',
        color: '#000',
    },
    headerCellRight: {
        flex: 1,
        fontWeight: 'bold',
        color: '#000',
        textAlign: 'right',
    },
    row: {
        flexDirection: 'row',
        paddingVertical: 12,
        borderBottomWidth: 1,
        borderColor: '#eee',
    },
    cellLeft: {
        flex: 1.2,
        fontSize: 14,
        color: '#333',
    },
    cellMiddle: {
        flex: 1.5,
        fontSize: 14,
        color: '#333',
    },
    cellRight: {
        flex: 1,
        fontSize: 14,
        color: '#000',
        fontWeight: '600',
        textAlign: 'right',
    },
    cellMiddleAddress: {
        flex: 1.5,
        justifyContent: 'center',
    },
    venueName: {
        fontSize: 14,
        color: '#333',
    },
    time: {
        fontSize: 12,
        color: '#888',
        marginTop: 2,
    },
    button: {
        paddingVertical: 6,
        paddingHorizontal: 12,
        backgroundColor: '#007BFF',
        borderRadius: 6,
    },
    buttonText: {
        color: '#fff',
        fontSize: 12,
        fontWeight: '500',
    },
    buttonDisabled: {
        backgroundColor: '#ccc',
    },
    buttonTextDisabled: {
        color: '#666',
        fontSize: 12,
        fontWeight: '500',
    }, reviewForm: {
        backgroundColor: "#f9f9f9",
        padding: 16,
        marginTop: 16,
        borderRadius: 8,
        borderWidth: 1,
        borderColor: "#ddd"
    },
    reviewTitle: {
        fontSize: 16,
        fontWeight: "bold",
        marginBottom: 8
    },
    starsRow: {
        flexDirection: "row",
        marginVertical: 8
    },
    textInput: {
        borderWidth: 1,
        borderColor: "#ccc",
        borderRadius: 6,
        padding: 8,
        minHeight: 60,
        textAlignVertical: "top",
    }
});

export default Review;
