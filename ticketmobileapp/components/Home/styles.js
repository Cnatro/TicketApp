import { StyleSheet } from "react-native";

export default StyleSheet.create({
  container: {
    padding: 16,
    backgroundColor: "#fff",
    flex: 1,
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
    marginTop: 8,
    borderRadius: 100,
    backgroundColor: "#f5f5f5",
    height: 48,
  },
});
