import React from "react";
import { ActivityIndicator, View, StyleSheet } from "react-native";

const Spinner = () => (
  <View style={styles.overlay}>
    <ActivityIndicator size="large" color="#0000ff" />
  </View>
);

const styles = StyleSheet.create({
  overlay: {
    position: "absolute",
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    backgroundColor: "rgba(0, 0, 0, 0.3)", // nền mờ
    justifyContent: "center",
    alignItems: "center",
    zIndex: 9999, // đè lên mọi thứ
  },
});

export default Spinner;
