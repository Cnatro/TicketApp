import { FlatList, Image, Text, View } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import styles from "./styles";
import { Icon, Searchbar } from "react-native-paper";
import { useEffect, useState } from "react";
import Apis, { endpoints } from "../../configs/Apis";

const Home = () => {
  const [events, setEvent] = useState([]);

  const loadEvent = async () => {
    try {
      let res = await Apis.get(endpoints["events"]);
      setEvent(res.data);
      console.log(res.data);
    } catch (error) {
        console.error("Lỗi khi tải sự kiện:", error);
    } finally {
    }
  };

  useEffect(() => {
    loadEvent();
  }, []);

  const renderEvent = ({ item }) => (
    <View style={styles.eventItem}>
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
  );

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <View>
          <Text style={styles.logo}>
            Zive
            <Text style={styles.logoGo}>Go</Text>
          </Text>
          <Text style={styles.slogan}>Đi chơi đâu, lên Zivego</Text>
        </View>

        <Icon source="bell-outline" size={24} color="black" />
      </View>

      <Searchbar
        style={styles.searchBar}
        placeholder="Tìm kiếm..."
        inputStyle={{ fontSize: 14, marginTop: 0, paddingBottom: 15 }}
        iconColor="#f15c22"
      />
      <FlatList
        data={events}
        keyExtractor={(item) => item.id.toString()}
        renderItem={renderEvent}
        contentContainerStyle={{ paddingHorizontal: 10, paddingTop: 10 }}
        ListEmptyComponent={<Text>Không có sự kiện nào</Text>}
      />
    </SafeAreaView>
  );
};
export default Home;
