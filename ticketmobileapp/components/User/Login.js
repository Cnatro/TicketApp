import {
  View,
  StyleSheet,
  TouchableOpacity,
  KeyboardAvoidingView,
  Platform,
  SafeAreaView,
} from "react-native";
import { Text, TextInput, Divider } from "react-native-paper";
import { GoogleLogo } from "phosphor-react-native";
import { useState } from "react";
import { useNavigation } from "@react-navigation/native";
import useAuth from "../../Hooks/useAuth";
import Apis, { authApis, endpoints } from "../../configs/Apis";
import Spinner from "../Utils/spinner";

const Login = () => {
  const [user, setUser] = useState({
    username: "",
    password: "",
  });
  const [loading, setLoading] = useState(false);
  const navigation = useNavigation();
  const [, auth] = useAuth();

  const setState = (value, field) => {
    setUser({ ...user, [field]: value });
  };

  const excuteLogin = async () => {
    try {
      setLoading(true);
      let res = await Apis.post(endpoints["login"], {
        ...user,
        client_id: "6OYmJrNXua1Qs7FyIr0CnJ9nC1u48nW6bMQ3diAT",
        client_secret:
          "7wITsQVtUX9klLPqzfIWpnmcI1qBkkDGG7g3zVj3SAojbn9eF3ui6DKc3SJ46gHpf0Ul860jsbt5pCcvV14QXp73YurggsXEFZBzD1FIMukLluXQ3YcwrGT4t5wPi2IE",
        grant_type: "password",
      });
      let u = await authApis(res.data.access_token).get(
        endpoints["current-user"]
      );
      auth.login(u.data);
      navigation.navigate("HomeStack", { screen: "Home" });
    } catch (error) {
      console.error("Lỗi đăng nhập", error);
    } finally {
      setLoading(false);
    }
  };
  return (
    <SafeAreaView style={styles.container}>
      {loading && <Spinner />}
      <KeyboardAvoidingView
        behavior={Platform.OS === "ios" ? "padding" : undefined}
        style={{ flex: 1 }}
      >
        <View style={styles.inner}>
          <Text style={styles.title}>Đăng nhập</Text>

          <TextInput
            label="Tên đăng nhập"
            mode="outlined"
            autoCapitalize="none"
            style={styles.input}
            value={user.username || ""}
            onChangeText={(text) => setState(text, "username")}
          />

          <TextInput
            label="Mật khẩu"
            mode="outlined"
            secureTextEntry
            style={styles.input}
            value={user.password || ""}
            onChangeText={(text) => setState(text, "password")}
          />

          <TouchableOpacity>
            <Text style={styles.forgot}>Quên mật khẩu?</Text>
          </TouchableOpacity>

          <TouchableOpacity style={styles.loginButton} onPress={excuteLogin}>
            <Text style={styles.loginButtonText}>Đăng nhập</Text>
          </TouchableOpacity>

          <View style={styles.dividerContainer}>
            <Divider style={{ flex: 1 }} />
            <Text style={styles.orText}>hoặc</Text>
            <Divider style={{ flex: 1 }} />
          </View>

          <TouchableOpacity style={styles.googleButton}>
            <GoogleLogo size={20} color="#EA4335" style={{ marginRight: 8 }} />
            <Text style={styles.googleButtonText}>Tiếp tục với Google</Text>
          </TouchableOpacity>
        </View>
      </KeyboardAvoidingView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    paddingHorizontal: 24,
  },
  inner: {
    flex: 1,
    justifyContent: "center",
  },
  title: {
    fontSize: 28,
    fontWeight: "bold",
    alignSelf: "center",
    marginBottom: 32,
  },
  input: {
    marginBottom: 16,
  },
  forgot: {
    alignSelf: "flex-end",
    color: "#555",
    marginBottom: 24,
    fontSize: 14,
  },
  loginButton: {
    backgroundColor: "#6200ee",
    paddingVertical: 12,
    borderRadius: 8,
    alignItems: "center",
    marginBottom: 24,
  },
  loginButtonText: {
    color: "#fff",
    fontWeight: "bold",
    fontSize: 16,
  },
  dividerContainer: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 24,
  },
  orText: {
    marginHorizontal: 10,
    color: "#888",
  },
  googleButton: {
    flexDirection: "row",
    borderColor: "#EA4335",
    borderWidth: 1.2,
    paddingVertical: 10,
    borderRadius: 8,
    justifyContent: "center",
    alignItems: "center",
  },
  googleButtonText: {
    color: "#EA4335",
    fontWeight: "600",
    fontSize: 15,
  },
});

export default Login;
