import React, { useEffect, useRef, useState } from "react";
import {
  Animated,
  StyleSheet,
  Text,
  View,
  StatusBar,
  FlatList,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Icon, Searchbar } from "react-native-paper";
import Category from "./Category";
import Event from "./Event";
import { TouchableOpacity } from "react-native";
import { useNavigation } from "@react-navigation/native";
import useAuth from "../../Hooks/useAuth";
import EventTopTrend from "./EventTopTrend";
import Apis, { endpoints } from "../../configs/Apis";

const Home = () => {
  const [userData] = useAuth();
  const user = userData?._j || null;
  const scrollY = useRef(new Animated.Value(0)).current;
  const navigation = useNavigation();
  const [q, setQ] = useState("");
  const [events, setEvents] = useState([]);
  const [loading, setLoading] = useState(false);
  const [page, setPage] = useState(1);

  const headerBackgroundColor = scrollY.interpolate({
    inputRange: [0, 100],
    outputRange: ["#ffffff", "#fbb676"],
    extrapolate: "clamp",
  });

  const loadEvents = async () => {
    if (page > 0) {
      try {
        setLoading(true);
        // console.log(page);
        let url = `${endpoints["events"]}/?page=${page}`;
        if (q) {
          url += `&q=${encodeURIComponent(q.trim())}`;
        }
        const res = await Apis.get(url);
        setEvents([...events,...res.data.results])
        // setEvents((prev) => {
        //   const existingIds = new Set(prev.map((event) => event.id));
        //   const newEvents = res.data.results.filter(
        //     (event) => !existingIds.has(event.id)
        //   );
        //   return [...prev, ...newEvents];
        // });

        if (res.data.next === null) {
          setPage(0);
        }
      } catch (err) {
        console.error("Lỗi tải sự kiện:", err);
      } finally {
        setLoading(false);
      }
    }
  };

  useEffect(() => {
    loadEvents();
  }, []);

  useEffect(() => {
    const timer = setTimeout(() => {
      loadEvents();
    }, 500);

    return () => clearTimeout(timer);
  }, [page, q]);

  const loadMore = () => {
    if (!loading && page > 0) setPage(page + 1);
  };

  const setSearch = (value, callback) => {
    setPage(1);
    setEvents([]);
    callback(value);
  };

  return (
    <SafeAreaView style={styles.safeArea}>
      <StatusBar barStyle="dark-content" backgroundColor="#fff" />
      <Animated.View
        style={[
          styles.headerContainer,
          { backgroundColor: headerBackgroundColor },
        ]}
      >
        <View style={styles.header}>
          <View>
            <TouchableOpacity
              onPress={() =>
                navigation.navigate("HomeStack", { screen: "Home" })
              }
            >
              <Text style={styles.logo}>
                Zive<Text style={styles.logoGo}>Go</Text>
              </Text>
            </TouchableOpacity>
            <Text style={styles.slogan}>Đi chơi đâu, lên Zivego</Text>
          </View>
          <View style={styles.iconContainer}>
            <Icon source="bell-outline" size={24} color="black" />
            {user !== null && (
              <TouchableOpacity
                style={styles.iconSpacing}
                onPress={() => navigation.navigate("ChatBox")}
              >
                <Icon source="message-reply-outline" size={24} color="black" />
              </TouchableOpacity>
            )}
          </View>
        </View>

        <Searchbar
          style={styles.searchBar}
          placeholder="Tìm kiếm..."
          inputStyle={styles.searchInput}
          iconColor="#f15c22"
          value={q}
          onChangeText={(t) => setSearch(t, setQ)}
        />
      </Animated.View>

      <FlatList
        data={[1]}
        keyExtractor={() => "unique-key"}
        renderItem={() => (
          <View style={styles.contentContainer}>
            <Category />
            {q === "" ? (
              <>
                <View style={styles.eventTitleContainer}>
                  <Text style={styles.eventTitle}>Sự kiện hot</Text>
                </View>
                <EventTopTrend />
              </>
            ) : null}
            <View style={styles.eventTitleContainer}>
              <Text style={styles.eventTitle}>Gợi ý sự kiện</Text>
            </View>
            <Event
              events={events}
              page={page}
              loading={loading}
              loadMore={loadMore}
            />
          </View>
        )}
        contentContainerStyle={styles.listContent}
        onScroll={Animated.event(
          [{ nativeEvent: { contentOffset: { y: scrollY } } }],
          { useNativeDriver: false }
        )}
        scrollEventThrottle={16}
      />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: "#fff",
  },
  headerContainer: {
    paddingHorizontal: 16,
    paddingTop: 10,
    paddingBottom: 12,
    borderBottomColor: "#ddd",
    borderBottomWidth: 1,
  },
  header: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  logo: {
    fontSize: 24,
    fontWeight: "bold",
    color: "#1c3f94",
  },
  logoGo: {
    color: "#f89c1c",
  },
  slogan: {
    fontSize: 12,
    color: "#1c3f94",
    marginTop: 2,
  },
  searchBar: {
    marginTop: 6,
    borderRadius: 100,
    backgroundColor: "#f5f5f5",
    height: 48,
  },
  searchInput: {
    fontSize: 14,
    paddingTop: 3,
  },
  eventTitleContainer: {
    width: "100%", // Chiếm toàn bộ chiều rộng để căn trái dễ dàng
    alignItems: "flex-start", // Đặt tiêu đề nằm bên trái
  },
  eventTitle: {
    fontSize: 22,
    fontWeight: "bold",
    color: "darkblue",
    marginTop: 8,
    marginBottom: 16,
    paddingHorizontal: 16, // Khoảng cách lề trái
  },
  contentContainer: {
    alignItems: "center",
    width: "100%",
  },
  listContent: {
    paddingBottom: 16,
  },
  iconContainer: {
    flexDirection: "row",
    alignItems: "center",
  },
  iconSpacing: {
    marginLeft: 10,
  },
});

export default Home;
