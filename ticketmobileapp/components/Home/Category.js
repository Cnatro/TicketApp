import { useEffect, useState } from "react";
import Apis, { endpoints } from "../../configs/Apis";
import {
  FlatList,
  Image,
  Text,
  TouchableOpacity,
  View,
  StyleSheet,
} from "react-native";
import { useNavigation } from "@react-navigation/native";

const Category = () => {
  const [category, setCategory] = useState([]);
  const navigation = useNavigation();

  const loadCategory = async () => {
    try {
      let res = await Apis.get(endpoints["categories"]);
      setCategory(res.data);
    } catch (error) {
      console.error("Lỗi khi tải danh mục:", error.message);
      console.log("Response lỗi:", error.response?.data);
    }
  };

  useEffect(() => {
    loadCategory();
  }, []);

  const renderItem = ({ item }) => (
    <TouchableOpacity style={styles.itemContainer}
      key={item.id}
      onPress={() =>
        navigation.navigate("EventCategory", { categoryId: item.id, categoryName: item.name })
      }
    >
      <View style={styles.iconWrapper}>
        <Image
          source={{ uri: item.img_name }}
          style={styles.icon}
          resizeMode="contain"
        />
      </View>
      <Text style={styles.label} numberOfLines={1}>
        {item.name}
      </Text>
    </TouchableOpacity>
  );

  return (
    <FlatList
      data={category}
      renderItem={renderItem}
      keyExtractor={(item) => item.id.toString()}
      horizontal={true}
      showsHorizontalScrollIndicator={false}
      contentContainerStyle={styles.listContainer}
    />
  );
};

const styles = StyleSheet.create({
  listContainer: {
    paddingVertical: 10,
  },
  itemContainer: {
    alignItems: "center",
    marginRight: 15,
    width: 70,
  },
  iconWrapper: {
    backgroundColor: "#f2f2f2",
    borderRadius: 30,
    padding: 10,
    elevation: 2,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
  },
  icon: {
    width: 40,
    height: 40,
  },
  label: {
    marginTop: 6,
    fontSize: 12,
    textAlign: "center",
    color: "#333",
  },
});

export default Category;
