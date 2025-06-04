import React, { useRef } from "react";
import { Animated, StyleSheet, Text, View, StatusBar } from "react-native";
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
  const headerBackgroundColor = scrollY.interpolate({
    inputRange: [0, 100],
    outputRange: ["#ffffff", "#fbb676"],
    extrapolate: "clamp",
  });

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
            <Text style={styles.logo}>
              Zive
              <Text style={styles.logoGo}>Go</Text>
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
        />
      </Animated.View>

      {/* Scrollable content */}
      <Animated.ScrollView
        style={styles.scrollView}
        onScroll={Animated.event(
          [{ nativeEvent: { contentOffset: { y: scrollY } } }],
          { useNativeDriver: false }
        )}
        scrollEventThrottle={16}
        showsVerticalScrollIndicator={false}
        contentContainerStyle={styles.scrollContent}
      >
        <Category />
        <Text style={styles.eventTitle}>Sự kiện</Text>
        <Event />
      </Animated.ScrollView>
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
    marginTop: 0,
    paddingBottom: 20,
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    paddingHorizontal: 16,
    paddingBottom: 30,
    paddingTop: 0,
  },
  eventTitle: {
    fontSize: 16,
    fontWeight: "bold",
    marginTop: 8,
    marginBottom: 16,
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
