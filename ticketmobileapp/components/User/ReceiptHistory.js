import AsyncStorage from "@react-native-async-storage/async-storage";
import { useEffect, useState } from "react";
import {
    View,
    Text,
    StyleSheet,
    FlatList,
} from "react-native";
import { authApis, endpoints } from "../../configs/Apis";
import Spinner from "../Utils/spinner";

const ReceiptHistory = () => {
    const [receipt, setReceipt] = useState([]);
    const [loading, setLoading] = useState(false);

    const loadReceipt = async () => {
        try {
            setLoading(true);
            const token = await AsyncStorage.getItem("token");
            let res = await authApis(token).get(`${endpoints["receipt"]}/receipt-history/`);
            setReceipt(res.data);
        } catch (error) {
            console.error("Lỗi load vé đã mua", error);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        loadReceipt();
    }, []);

    const renderItem = ({ item }) => (
        <View style={styles.row}>
            <Text style={styles.cellLeft} numberOfLines={1}>{item.event_name}</Text>

            <View style={styles.cellMiddleAddress}>
                <Text style={styles.venueName} numberOfLines={1}>{item.venue_name}</Text>
                <Text style={styles.venueAddress} numberOfLines={1}>{item.venue_address}</Text>
            </View>

            <Text style={styles.cellRight}>{parseInt(item.total_price).toLocaleString()}đ</Text>
        </View>
    );

    return (
        <View style={styles.container}>
            {loading && <Spinner />}
            {receipt && receipt.length > 0 ? (
                <>
                    <View style={styles.headerRow}>
                        <Text style={styles.headerCellLeft}>Sự kiện</Text>
                        <Text style={styles.headerCellMiddle}>Địa chỉ</Text>
                        <Text style={styles.headerCellRight}>Tổng giá</Text>
                    </View>
                    <FlatList
                        scrollEnabled={false}
                        data={receipt}
                        keyExtractor={item => item.id.toString()}
                        renderItem={renderItem}
                        contentContainerStyle={{ paddingBottom: 20 }}
                    />
                </>
            ) : (
                <Text style={{ padding: 16 }}>Bạn chưa có giao dịch nào trên ZiveGO</Text>
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
    venueAddress: {
        fontSize: 12,
        color: '#888',
        marginTop: 2,
    },
});

export default ReceiptHistory;
