import React, { useRef } from "react";
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

const Home = () => {
  const scrollY = useRef(new Animated.Value(0)).current;
  const headerBackgroundColor = scrollY.interpolate({
    inputRange: [0, 100],
    outputRange: ["#ffffff", "#fbb676"],
    extrapolate: "clamp",
  });

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
          <Icon source="bell-outline" size={24} color="black" />
        </View>

        <Searchbar
          style={styles.searchBar}
          placeholder="Tìm kiếm..."
          inputStyle={styles.searchInput}
          iconColor="#f15c22"
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
            <Event />
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
});

export default Home;
