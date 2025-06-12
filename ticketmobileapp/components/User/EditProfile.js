import AsyncStorage from "@react-native-async-storage/async-storage";
import { useEffect, useState } from "react";
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Image,
  ScrollView,
} from "react-native";
import { TextInput, Button } from "react-native-paper";
import * as ImagePicker from "expo-image-picker";
import { authApis, endpoints } from "../../configs/Apis";
import Spinner from "../Utils/spinner";

const EditProfile = () => {
  const [user, setUser] = useState({ password: "" });
  const [originalUser, setOriginalUser] = useState({});
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [confirmPassword, setConfirmPassword] = useState("");

  const fields = [
    { label: "Họ", field: "last_name" },
    { label: "Tên", field: "first_name" },
    { label: "Email", field: "email" },
    { label: "Số điện thoại", field: "phone" },
    { label: "Địa chỉ", field: "address" },
    { label: "Mật khẩu", field: "password", secure: true },
  ];

  const setState = (value, field) => {
    setUser({ ...user, [field]: value });
  };

  const validation = () => {
    const keysToCheck = ["first_name", "last_name", "email", "phone", "address", "password"];
    for (let key of keysToCheck) {
      if ((user[key] || "") !== (originalUser[key] || "")) return true;
    }

    // Nếu avatar là ảnh mới chọn
    if (user.avatar && user.avatar.uri) return true;

    return false;
  };

  const loadUser = async () => {
    try {
      setLoading(true);
      const token = await AsyncStorage.getItem("token");
      const res = await authApis(token).get(endpoints["current-user"]);
      setUser(res.data);
      setOriginalUser(res.data);
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const pickImage = async () => {
    const result = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: ImagePicker.MediaTypeOptions.Images,
      allowsEditing: true,
      aspect: [1, 1],
      quality: 1,
    });
    if (!result.canceled && result.assets?.[0]) {
      setUser({ ...user, avatar: { uri: result.assets[0].uri } });
    }
  };

  const saveProfile = async () => {
    if (user.password && user.password !== confirmPassword) {
      alert("Mật khẩu và xác minh mật khẩu không khớp!");
      return;
    }

    const formData = new FormData();
    for (let key of Object.keys(user)) {
      if (key !== "avatar" && (key !== "password" || user[key])) {
        formData.append(key, user[key]);
      }
    }

    if (user.avatar && user.avatar.uri) {
      const filename = user.avatar.uri.split("/").pop();
      const match = /\.([^.]+)$/.exec(filename);
      const type = match ? `image/${match[1]}` : `image`;
      formData.append("avatar", {
        uri: user.avatar.uri,
        name: filename,
        type,
      });
    }

    try {
      setSaving(true);
      const token = await AsyncStorage.getItem("token");
      await authApis(token).patch(endpoints["current-user"], formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });
      alert("Lưu thông tin thành công!");
      await loadUser(); // cập nhật lại bản gốc
      setConfirmPassword(""); // xóa xác minh mật khẩu
    } catch (err) {
      console.error(err);
      alert("Có lỗi xảy ra khi lưu.");
    } finally {
      setSaving(false);
    }
  };

  useEffect(() => {
    loadUser();
  }, []);

  if (loading) return <Spinner />;

  return (
    <ScrollView contentContainerStyle={styles.container}>
      <Text style={styles.header}>Sửa Hồ sơ</Text>
      <TouchableOpacity onPress={pickImage} style={styles.avatarContainer}>
        {user.avatar?.uri ? (
          <Image source={{ uri: user.avatar.uri }} style={styles.avatar} />
        ) : (
          <Image source={{ uri: user.avatar }} style={styles.avatar} />
        )}
        <Text style={styles.changeAvatar}>Sửa</Text>
      </TouchableOpacity>

      {fields.map((f) => (
        <TextInput
          key={f.field}
          label={f.label}
          value={user[f.field] || ""}
          onChangeText={(text) => setState(text, f.field)}
          style={styles.input}
          secureTextEntry={f.secure || false}
        />
      ))}
      <TextInput
        label="Xác minh mật khẩu"
        value={confirmPassword}
        onChangeText={(text) => setConfirmPassword(text)}
        style={styles.input}
        secureTextEntry={true}
      />

      <Button
        mode="contained"
        onPress={saveProfile}
        disabled={!validation() || saving}
        style={styles.button}
      >
        {saving ? "Đang lưu..." : "Lưu"}
      </Button>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 16,
    backgroundColor: "#fff",
  },
  header: {
    fontSize: 20,
    fontWeight: "bold",
    textAlign: "center",
    marginVertical: 16,
  },
  avatarContainer: {
    alignItems: "center",
    marginBottom: 16,
  },
  avatar: {
    width: 100,
    height: 100,
    borderRadius: 50,
  },
  changeAvatar: {
    color: "#007BFF",
    marginTop: 8,
  },
  input: {
    marginBottom: 12,
  },
  button: {
    marginTop: 20,
  },
});

export default EditProfile;
