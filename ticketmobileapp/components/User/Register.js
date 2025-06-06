import { useNavigation } from "@react-navigation/native";
import React, { useState } from "react";
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  StyleSheet,
  ScrollView,
  Image,
  KeyboardAvoidingView,
  TouchableWithoutFeedback,
  Keyboard,
  Platform,
} from "react-native";
import * as ImagePicker from "expo-image-picker";
import Spinner from "../Utils/spinner";
import Apis, { endpoints } from "../../configs/Apis";

const Register = () => {
  const navigation = useNavigation();
  const [role, setRole] = useState(1);
  const [user, setUser] = useState({});
  const [loading, setLoading] = useState(false);
  const [errors, setErrors] = useState({});

  const personalInfo = [
    { label: "Họ tên", field: "full_name", placeholder: "Họ và tên của bạn" },
    { label: "SĐT", field: "phone", placeholder: "Số điện thoại" },
    { label: "Email", field: "email", placeholder: "Nhập Email của bạn" },
  ];

  const loginInfo = [
    { label: "Tài khoản", field: "username", placeholder: "Tài khoản" },
    {
      label: "Mật khẩu",
      field: "password",
      placeholder: "Nhập mật khẩu",
      secureTextEntry: true,
    },
    {
      label: "Mật khẩu nhập lại",
      field: "confirm",
      placeholder: "Mật khẩu nhập lại",
      secureTextEntry: true,
    },
  ];

  const validateFields = () => {
    const requiredFields = [
      "full_name",
      "phone",
      "email",
      "username",
      "password",
      "confirm",
    ];

    let newErrors = {};
    requiredFields.forEach((field) => {
      if (!user[field] || user[field].trim() === "") {
        newErrors[field] = "Trường này không được để trống!";
      }
    });

    if (user.password !== user.confirm) {
      newErrors["confirm"] = "Mật khẩu nhập lại không khớp!";
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const setState = (value, field) => {
    setUser({ ...user, [field]: value });
  };

  const splitFullName = (fullName) => {
    const parts = fullName.trim().split(" ");
    const firstName = parts.pop();
    const lastName = parts.join(" ");
    return { first_name: firstName, last_name: lastName };
  };

  const picker = async () => {
    let { status } = await ImagePicker.requestMediaLibraryPermissionsAsync();
    if (status !== "granted") {
      alert("Permissions denied!");
    } else {
      const result = await ImagePicker.launchImageLibraryAsync();

      if (!result.canceled) setState(result.assets[0], "avatar");
    }
  };

  const registerUser = async () => {
    if (!validateFields()) return;

    const { first_name, last_name } = splitFullName(user.full_name);
    const userReal = {
      ...user,
      role: role === 1 ? "ROLE_CUSTOMER" : "ROLE_EVENT_ORIGANEZE",
      first_name,
      last_name,
    };
    try {
      setLoading(true);

      let form = new FormData();
      for (let key in userReal)
        if (key !== "confirm" && key !== "full_name") {
          if (key === "avatar") {
            const localUri = userReal.avatar.uri;
            const filename = localUri.split("/").pop();

            // Lấy phần đuôi để đoán MIME type
            const match = /\.(\w+)$/.exec(filename || "");
            const ext = match?.[1]?.toLowerCase();
            const type =
              ext === "png"
                ? "image/png"
                : ext === "jpg" || ext === "jpeg"
                ? "image/jpeg"
                : "image";

            form.append("avatar", {
              uri: localUri,
              name: filename || `avatar.${ext || "jpg"}`,
              type: type,
            });
          } else form.append(key, userReal[key]);
        }

      console.log(form._parts);
      let res = await Apis.post(endpoints["register"], form, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });

      if (res.status === 201) navigation.navigate("Login");
    } catch (ex) {
      console.error("Lỗi đang kí người dùng", ex);
    } finally {
      setLoading(false);
    }
  };

  return (
    <KeyboardAvoidingView
      behavior={Platform.OS === "ios" ? "padding" : "height"}
      style={{ flex: 1 }}
    >
      <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
        <ScrollView
          contentContainerStyle={styles.container}
          keyboardShouldPersistTaps="handled"
        >
          {loading && <Spinner />}
          <Text style={styles.title}>Đăng ký</Text>
          <Text style={styles.subtitle}>Đăng ký tài khoản thành viên</Text>

          {personalInfo.map((item) => (
            <View key={item.field} style={styles.inputGroup}>
              <Text style={styles.label}>{item.label}</Text>
              <TextInput
                style={styles.input}
                placeholder={item.placeholder}
                value={user[item.field]}
                onChangeText={(text) => setState(text, item.field)}
              />
              {errors[item.field] && (
                <Text style={styles.errorText}>{errors[item.field]}</Text>
              )}
            </View>
          ))}

          <Text style={styles.label}>Vai trò</Text>
          <View style={styles.roleContainer}>
            <TouchableOpacity
              style={[styles.roleButton, role === 1 && styles.roleSelectedLeft]}
              onPress={() => setRole(1)}
            >
              <Text
                style={[styles.roleText, role === 1 && styles.roleTextSelected]}
              >
                Khách hàng
              </Text>
            </TouchableOpacity>
            <TouchableOpacity
              style={[
                styles.roleButton,
                role === 2 && styles.roleSelectedRight,
              ]}
              onPress={() => setRole(2)}
            >
              <Text
                style={[styles.roleText, role === 2 && styles.roleTextSelected]}
              >
                Nhà tổ chức
              </Text>
            </TouchableOpacity>
          </View>
          <TouchableOpacity onPress={picker}>
            <Text>Chọn ảnh đại diện...</Text>
          </TouchableOpacity>
          {user?.avatar && (
            <View style={{ alignItems: "center", marginVertical: 16 }}>
              <Image
                source={{ uri: user.avatar.uri }}
                style={{
                  width: 120,
                  height: 120,
                  borderRadius: 60,
                  borderWidth: 2,
                  borderColor: "#6A1B9A",
                }}
              />
            </View>
          )}

          <Text style={styles.sectionTitle}>Thông tin đăng nhập</Text>

          {loginInfo.map((item) => (
            <View key={item.field} style={styles.inputGroup}>
              <Text style={styles.label}>{item.label}</Text>
              <TextInput
                style={styles.input}
                placeholder={item.placeholder}
                secureTextEntry={item.secureTextEntry}
                value={user[item.field]}
                onChangeText={(text) => setState(text, item.field)}
              />
              {errors[item.field] && (
                <Text style={styles.errorText}>{errors[item.field]}</Text>
              )}
            </View>
          ))}

          <TouchableOpacity style={styles.button} onPress={registerUser}>
            <Text style={styles.buttonText}>Đăng kí</Text>
          </TouchableOpacity>

          <TouchableOpacity onPress={() => navigation.navigate("Login")}>
            <Text style={styles.footerText}>Đăng nhập</Text>
          </TouchableOpacity>
        </ScrollView>
      </TouchableWithoutFeedback>
    </KeyboardAvoidingView>
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 20,
    backgroundColor: "#fff",
  },
  title: {
    fontSize: 20,
    fontWeight: "bold",
    textAlign: "center",
    marginBottom: 4,
  },
  subtitle: {
    textAlign: "center",
    color: "#666",
    marginBottom: 20,
  },
  sectionTitle: {
    fontWeight: "bold",
    fontSize: 16,
    marginTop: 20,
    marginBottom: 8,
  },
  inputGroup: {
    marginBottom: 12,
  },
  label: {
    fontSize: 12,
    color: "#666",
    marginBottom: 4,
  },
  input: {
    borderWidth: 1,
    borderColor: "#ccc",
    borderRadius: 12,
    paddingHorizontal: 16,
    paddingVertical: 10,
    fontSize: 14,
  },
  button: {
    backgroundColor: "#6A1B9A",
    paddingVertical: 12,
    borderRadius: 24,
    alignItems: "center",
    marginTop: 20,
    marginBottom: 10,
  },
  buttonText: {
    color: "#fff",
    fontWeight: "bold",
    fontSize: 16,
  },
  footerText: {
    color: "#666",
    textAlign: "center",
    textDecorationLine: "underline",
  },
  roleContainer: {
    flexDirection: "row",
    borderRadius: 25,
    overflow: "hidden",
    borderWidth: 1,
    borderColor: "#ccc",
    alignSelf: "flex-start",
    marginBottom: 20,
  },
  roleButton: {
    paddingVertical: 10,
    paddingHorizontal: 20,
    backgroundColor: "#fff",
  },
  roleSelectedLeft: {
    backgroundColor: "#6A1B9A",
    borderTopLeftRadius: 25,
    borderBottomLeftRadius: 25,
  },
  roleSelectedRight: {
    backgroundColor: "#6A1B9A",
    borderTopRightRadius: 25,
    borderBottomRightRadius: 25,
  },
  roleText: {
    color: "#333",
  },
  roleTextSelected: {
    color: "#fff",
    fontWeight: "bold",
  },
  errorText: {
    color: "red",
    fontSize: 12,
    marginTop: 4,
  },
});

export default Register;
