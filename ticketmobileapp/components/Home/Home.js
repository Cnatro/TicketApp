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

const Home = () => {
  const [userData] = useAuth();
  const user = userData?._j || null;
  const scrollY = useRef(new Animated.Value(0)).current;
  const navigation = useNavigation();
  const [debouncedQuery, setDebouncedQuery] = useState("");
  const [searchQuery, setSearchQuery] = useState("");
  const headerBackgroundColor = scrollY.interpolate({
    inputRange: [0, 100],
    outputRange: ["#ffffff", "#fbb676"],
    extrapolate: "clamp",
  });

  useEffect(() => {
    const delayDebounce = setTimeout(() => {
      setSearchQuery(debouncedQuery); // Chỉ cập nhật sau 500ms nếu không gõ nữa
    }, 500);
    return () => clearTimeout(delayDebounce);
  }, [debouncedQuery]);

  const onChangeSearch = (query) => {
    setSearchQuery(query); // Cập nhật từ khóa tìm kiếm
  };

  return (
    <SafeAreaView style={styles.safeArea}>
      <StatusBar barStyle="dark-content" backgroundColor="#fff" />
      <Animated.View
        style={[styles.headerContainer, { backgroundColor: headerBackgroundColor }]}
      >
        <View style={styles.header}>
          <View>
            <Text style={styles.logo}>
              Zive<Text style={styles.logoGo}>Go</Text>
            </Text>
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
          value={debouncedQuery}
          onChangeText={onChangeSearch}
        />
      </Animated.View>

      <FlatList
        data={[1]} // dummy data để render nội dung duy nhất 1 lần
        keyExtractor={() => "unique-key"}
        renderItem={() => (
          <View style={styles.contentContainer}> {/* Thêm container để căn giữa */}
            <Category />
            <View style={styles.eventTitleContainer}>
              <Text style={styles.eventTitle}>Sự kiện</Text>
            </View>
            <Event searchQuery={searchQuery} />
          </View>
        )}
        contentContainerStyle={styles.listContent} // Thêm style cho content của FlatList
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
