// import AsyncStorage from "@react-native-async-storage/async-storage";
// import dayjs from "dayjs";
// import * as Notifications from "expo-notifications";
// import { Alert } from "react-native";
// import { authApis, endpoints } from "../../configs/Apis";

// export const requestPermissionNotification = async () => {
//   const { status: existingStatus } = await Notifications.getPermissionsAsync();
//   let finalStatus = existingStatus;

//   if (existingStatus !== "granted") {
//     const { status } = await Notifications.requestPermissionsAsync();
//     finalStatus = status;
//   }

//   if (finalStatus !== "granted") {
//     Alert.alert("Thông báo", "Bạn không thể nhận thông báo");
//   }
// };

// export const sheduleNoticationsForTickets = async () => {
//   try {
//     const token = await AsyncStorage.getItem("token");
//     if (token) {
//       let res = await authApis(token).get(`${endpoints["receipt"]}/latest/`);
//       const receiptList = res.data;

//       for (let receipt of receiptList) {
//         const { tickets } = receipt;

//         for (let ticket of tickets) {
//           const match = ticket.code_qr.match(/TIME: (.*?) -/);
//           if (!match) continue;

//           const eventStartTime = match[1];
//           const notifcationTime = dayjs(eventStartTime).subtract(1, "day"); // nhắc trước 1 ngày

//           if (notifcationTime.isAfter(dayjs())) {
//             await Notifications.scheduleNotificationAsync({
//               content: {
//                 title: "Sắp đến sự kiện!",
//                 body: `Bạn đã đặt vé cho sự kiện "${ticket.event_name}" sẽ bắt đầu lúc ${eventStartTime}. Đừng quên tham gia nhé!`,
//                 sound: "default",
//               },
//               trigger: notifyTime.toDate(),
//             });
//           }
//         }
//       }
//     }
//   } catch (error) {
//     // console.error("Lỗi load sự kiện đã đăng kí của user để thông báo", error);
//   }
// };
