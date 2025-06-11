import React, { useState } from "react";
import {
  View,
  Text,
  StyleSheet,
  Image,
  ScrollView,
  TouchableOpacity,
  SafeAreaView,
} from "react-native";
import { Divider, IconButton, ProgressBar } from "react-native-paper";
import Icon from "react-native-vector-icons/MaterialIcons";
import useAuth from "../../Hooks/useAuth";
import { useNavigation } from "@react-navigation/native";
import ReceiptHistory from "./ReceiptHistory";
import Review from "./Review";

const Profile = () => {
  const [activeTab, setActiveTab] = useState("info");
  const [userData, auth] = useAuth();
  const navigation = useNavigation()
  const progress = 180 / 10000;
  const user = userData._j;
  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: "#fff" }}>
      <ScrollView style={styles.container}>
        {/* Header */}
        <View style={styles.header}>
          <Text style={styles.headerText}>THÀNH VIÊN</Text>
          <IconButton icon="cog" size={24} onPress={() => { }} />
        </View>

        {/* Avatar + Info */}
        <View style={styles.profileContainer}>
          <Image
            source={{
              uri: user?.avatar
                ? user.avatar
                : "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg?semt=ais_hybrid&w=740",
            }}
            style={styles.avatar}
          />
          <View style={styles.userInfo}>
            <Text style={styles.name}>{user.username}</Text>
            <Text style={styles.rank}>C'Friends</Text>
            <Text style={styles.email}>{user.email}</Text>
          </View>
        </View>
        {/* Tabs (mô phỏng) */}
        <View style={styles.tabs}>
          <TouchableOpacity onPress={() => setActiveTab("info")}>
            <Text style={[styles.tabItem, activeTab === "info" && styles.activeTab]}>
              Thông tin
            </Text>
          </TouchableOpacity>
          <TouchableOpacity onPress={() => setActiveTab("receipt")}>
            <Text style={[styles.tabItem, activeTab === "receipt" && styles.activeTab]}>
              Giao dịch
            </Text>
          </TouchableOpacity>
          <TouchableOpacity onPress={() => setActiveTab("review")}>
            <Text style={[styles.tabItem, activeTab === "review" && styles.activeTab]}>
              Đánh giá
            </Text>
          </TouchableOpacity>
        </View>

        {/* Progress bar */}
        {activeTab === "info" ? (
          <>
            <View style={styles.progressSection}>
              <Text style={styles.levelLabel}>Cấp độ thành viên</Text>
              <View style={styles.levelText}>
                <Text style={styles.rank}>C'Friends</Text>
                <Text style={styles.rank}>C'VIP</Text>
              </View>
              <ProgressBar
                progress={progress}
                color="#8e24aa"
                style={styles.progressBar}
              />
              <View style={styles.progressRange}>
                <Text>0</Text>
                <Text>10,000</Text>
              </View>
            </View>

            <Divider />

            <MenuItem label="Thông tin cá nhân" />
            <MenuItem label="Đổi mật khẩu" />
            <MenuItem label="Vé đã mua" onNavigator={() => navigation.navigate("Receipted")} />
            <MenuItem label="Hỏi đáp" />
            <View style={styles.hotline}>
              <Text style={styles.hotlineLabel}>Hotline:</Text>
              <Text style={styles.hotlineNumber}>028 7300 8881</Text>
            </View>
            <View style={styles.buttonContainer}>
              <TouchableOpacity
                style={styles.logoutButton}
                onPress={() => auth.logout()}
              >
                <Text style={styles.logoutText}>Đăng xuất</Text>
              </TouchableOpacity>
            </View>
          </>
        ) : activeTab === "receipt" ? (
          <ReceiptHistory />
        ) : (
          <Review />
        )}

      </ScrollView>
    </SafeAreaView>
  );
};

const MenuItem = ({ label, onNavigator }) => (
  <TouchableOpacity style={styles.menuItem} onPress={onNavigator}>
    <Text style={styles.menuText}>{label}</Text>
    <Icon name="keyboard-arrow-right" size={24} color="#999" />
  </TouchableOpacity>
);

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: "#fff", paddingHorizontal: 16 },
  header: {
    flexDirection: "row",
    justifyContent: "space-between",
    paddingTop: 16,
    alignItems: "center",
  },
  headerText: { fontSize: 16, fontWeight: "bold" },
  profileContainer: {
    flexDirection: "row",
    alignItems: "center",
    marginVertical: 12,
  },
  avatar: { width: 60, height: 60, borderRadius: 30, backgroundColor: "#ccc" },
  userInfo: { marginLeft: 16 },
  name: { fontSize: 16, fontWeight: "bold" },
  rank: { fontSize: 14, color: "#888" },
  email: { fontSize: 13, color: "#555" },
  pointsContainer: {
    flexDirection: "row",
    justifyContent: "space-around",
    marginVertical: 8,
  },
  pointItem: { alignItems: "center" },
  pointTitle: { fontSize: 12, color: "#666" },
  pointValue: { fontSize: 14, fontWeight: "bold" },
  tabs: {
    flexDirection: "row",
    justifyContent: "center",
    marginTop: 12,
    marginBottom: 8,
  },
  tabItem: {
    marginHorizontal: 20,
    fontSize: 14,
    color: "#888",
  },
  activeTab: {
    color: "#000",
    fontWeight: "bold",
    textDecorationLine: "underline",
  },
  progressSection: { marginVertical: 12 },
  levelLabel: { fontSize: 14, fontWeight: "bold" },
  levelText: {
    flexDirection: "row",
    justifyContent: "space-between",
    marginTop: 4,
  },
  progressBar: {
    height: 8,
    borderRadius: 4,
    backgroundColor: "#eee",
    marginTop: 8,
  },
  progressRange: {
    flexDirection: "row",
    justifyContent: "space-between",
    marginTop: 4,
  },
  menuItem: {
    flexDirection: "row",
    justifyContent: "space-between",
    paddingVertical: 12,
    borderBottomColor: "#eee",
    borderBottomWidth: 1,
  },
  menuText: { fontSize: 14 },
  hotline: {
    flexDirection: "row",
    justifyContent: "center",
    marginVertical: 16,
  },
  hotlineLabel: { fontWeight: "bold", marginRight: 4 },
  hotlineNumber: { color: "#03a9f4" },
  buttonContainer: {
    alignItems: "center",
    marginVertical: 24,
  },
  logoutButton: {
    backgroundColor: "#d32f2f",
    paddingVertical: 12,
    paddingHorizontal: 60,
    borderRadius: 30,
    elevation: 3,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
  },
  logoutText: {
    color: "#fff",
    fontWeight: "bold",
    fontSize: 16,
  },
});

export default Profile;
