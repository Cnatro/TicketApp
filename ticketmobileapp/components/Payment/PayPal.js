import React, { useEffect, useRef, useState } from "react";
import { ActivityIndicator, Alert, View } from "react-native";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { WebView } from "react-native-webview";
import { useNavigation } from "@react-navigation/native";
import { authApis, endpoints } from "../../configs/Apis";

const PayPal = ({ route }) => {
  const { totalPrice, onReceipt } = route.params;
  const returnUrl = "https://zivego.com/success";
  const cancelUrl = "https://zivego.com/cancel";
  const [approvalUrl, setApprovalUrl] = useState(null);
  const [loading, setLoading] = useState(false);
  const webViewRef = useRef(null);
  const navigation = useNavigation();

  const loadApprovalUrl = async () => {
    try {
      setLoading(true);
      const token = await AsyncStorage.getItem("token");

      console.log(totalPrice);
      console.log(token);
      console.log(`${endpoints["paypal"]}/create-payment/`);
      const res = await authApis(token).post(
        `${endpoints["paypal"]}/create-payment/`,
        {
          total: (totalPrice / 2500000).toFixed(2),
          return_url: returnUrl,
          cancel_url: cancelUrl,
        }
      );
      setApprovalUrl(res.data.approval_url);
    } catch (err) {
      console.error("Error loading approval URL", err);
      Alert.alert("Lỗi", "Không thể khởi tạo thanh toán.");
    } finally {
      setLoading(false);
    }
  };

  const handleNavigationChange = async (navState) => {
    const { url } = navState;

    if (url.startsWith(returnUrl)) {
      const params = new URLSearchParams(url.split("?")[1]);
      const payer_id = params.get("PayerID");
      const payment_id = params.get("paymentId");

      if (payer_id && payment_id) {
        try {
          setLoading(true);
          const token = await AsyncStorage.getItem("token");

          const res = await authApis(token).post(
            `${endpoints["paypal"]}/execute-payment/`,
            {
              payer_id,
              payment_id,
            }
          );

          if (res.data.status === "success") {
            await onReceipt();
            // Alert.alert("Thanh toán","Thanh toán thành công");
          } else {
            Alert.alert(
              "Thanh toán thất bại",
              "Không thể xác nhận thanh toán."
            );
            navigation.goBack();
          }
        } catch (err) {
          console.error("Execute payment error", err);
          Alert.alert("Lỗi", "Không thể hoàn tất thanh toán.");
        } finally {
          setLoading(false);
        }
      }
    } else if (url.startsWith(cancelUrl)) {
      Alert.alert("Đã hủy", "Bạn đã hủy thanh toán.");
      navigation.goBack();
    }
  };

  useEffect(() => {
    loadApprovalUrl();
  }, []);

  if (loading || !approvalUrl) {
    return (
      <View style={{ flex: 1, justifyContent: "center", alignItems: "center" }}>
        <ActivityIndicator size="large" color="#0000ff" />
      </View>
    );
  }

  return (
    <WebView
      ref={webViewRef}
      source={{ uri: approvalUrl }}
      onNavigationStateChange={handleNavigationChange}
      startInLoadingState={true}
      javaScriptEnabled={true}
      style={{ flex: 1 }}
    />
  );
};

export default PayPal;
