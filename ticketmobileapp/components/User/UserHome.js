import React from "react";
import { View, StyleSheet, TouchableOpacity } from "react-native";
import { Text } from "react-native-paper";
import Icon from "react-native-vector-icons/MaterialCommunityIcons";
import Profile from "./Profile";
import useAuth from "../../Hooks/useAuth";

const UserHome = ({navigation}) => {
  const [userData] = useAuth();
  const user = userData?._j || null;
  return (
    <>
      {user !== null ? (
        <Profile />
      ) : (
        <View style={styles.container}>
          {/* Header */}
          <View style={styles.header}>
            <Text style={styles.headerText}>THÀNH VIÊN</Text>
            <Icon name="cog-outline" size={24} color="#555" />
          </View>

          <View style={styles.content}>
            <View style={styles.avatarContainer}>
              <Icon name="account-circle" size={90} color="#999" />
            </View>
            <Text style={styles.title}>Đăng ký thành viên</Text>
            <Text style={styles.subtitle}>Nhận ngay ưu đãi</Text>

            <View style={styles.buttonContainer}>
              <TouchableOpacity
                style={[styles.button, styles.registerButton]}
                onPress={() => navigation.navigate("Register")}
              >
                <Text style={styles.registerText}>Đăng ký</Text>
              </TouchableOpacity>

              <TouchableOpacity
                style={[styles.button, styles.loginButton]}
                onPress={() => navigation.navigate("Login")}
              >
                <Text style={styles.loginText}>Đăng nhập</Text>
              </TouchableOpacity>
            </View>
          </View>
        </View>
      )}
    </>
  );
};

export default UserHome;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
  },
  header: {
    paddingTop: 50,
    paddingBottom: 12,
    paddingHorizontal: 20,
    flexDirection: "row",
    justifyContent: "space-between",
    borderBottomWidth: 1,
    borderBottomColor: "#eee",
    backgroundColor: "#fff",
  },
  headerText: {
    fontSize: 16,
    fontWeight: "600",
    color: "#555",
  },
  content: {
    flex: 1,
    alignItems: "center",
    paddingTop: 40,
  },
  avatarContainer: {
    marginBottom: 16,
  },
  title: {
    fontSize: 16,
    fontWeight: "bold",
    color: "#333",
  },
  subtitle: {
    color: "#888",
    marginTop: 4,
    marginBottom: 24,
  },
  buttonContainer: {
    flexDirection: "row",
    gap: 12,
    textAlign:"center"
  },
  button: {
    paddingVertical: 10,
    paddingHorizontal: 24,
    borderRadius: 6,
  },
  registerButton: {
    backgroundColor: "#6A1B9A",
  },
  registerText: {
    color: "#fff",
    fontWeight: "bold",
  },
  loginButton: {
    borderWidth: 1.2,
    borderColor: "#6A1B9A",
    backgroundColor: "#fff",
  },
  loginText: {
    color: "#6A1B9A",
    fontWeight: "bold",
  },
});
