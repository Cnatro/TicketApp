import React, { useEffect, useRef, useState } from "react";
import {
  KeyboardAvoidingView,
  Platform,
  ScrollView,
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
  TouchableWithoutFeedback,
  Keyboard,
} from "react-native";
import { Icon, TextInput } from "react-native-paper";
import Apis, { authApis, endpoints, webSocketUrl } from "../../configs/Apis";
import useAuth from "../../Hooks/useAuth";
import AsyncStorage from "@react-native-async-storage/async-storage";
import Spinner from "../Utils/spinner";

const ChatBox = () => {
  const [userData] = useAuth();
  const user = userData?._j || null;
  const [messages, setMessages] = useState([]);
  const [inputValue, setInputValue] = useState("");
  const scrollViewRef = useRef(null);
  const socketRef = useRef(null);
  const [loading, setLoading] = useState(false);

  const loadMessage = async () => {
    try {
      setLoading(true);
      const token = await AsyncStorage.getItem("token");
      let res = await authApis(token).get(endpoints["chat-room"]);
      setMessages(res.data);
    } catch (error) {
      console.error("Lỗi load tin nhắn", error);
    } finally {
      setLoading(false);
    }
  };

  function formatTime(dateString) {
    if (!dateString) return "--:--";
    const date = new Date(dateString);
    const hours = date.getHours().toString().padStart(2, "0");
    const minutes = date.getMinutes().toString().padStart(2, "0");
    return `${hours}:${minutes}`;
  }

  useEffect(() => {
    loadMessage();
  }, []);

  useEffect(() => {
    console.log(`${webSocketUrl}/room_${user.id}/`);
    socketRef.current = new WebSocket(`${webSocketUrl}/room_${user.id}/`);

    socketRef.current.onmessage = (event) => {
      const data = JSON.parse(event.data);
      setMessages((prevMessages) => {
        if (prevMessages.find((msg) => msg.id === data.id)) {
          return prevMessages;
        }
        return [...prevMessages, data];
      });
    };

    socketRef.current.onopen = () => {
      console.log("WebSocket connected");
    };

    socketRef.current.onerror = (error) => {
      console.log("WebSocket error:", error);
    };

    socketRef.current.onclose = () => {
      console.log("WebSocket disconnected");
    };

    return () => {
      socketRef.current.close();
    };
  }, []);

  const sendMessage = () => {
    if (inputValue.trim() === "") return;

    const messageData = {
      message: inputValue,
      sender: user.username,
      // time: new Date().toLocaleTimeString().slice(0, 5),
    };

    socketRef.current.send(JSON.stringify(messageData));
    // setMessages((prevMessages) => [...prevMessages, messageData]);
    setInputValue("");
  };

  return (
    <KeyboardAvoidingView
      style={{ flex: 1 }}
      behavior={Platform.OS === "ios" ? "padding" : "padding"}
      keyboardVerticalOffset={Platform.OS === "ios" ? 80 : 0}
    >
      <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
        <View style={styles.container}>
          {loading && <Spinner />}

          <ScrollView
            ref={scrollViewRef}
            contentContainerStyle={styles.chatContainer}
            keyboardShouldPersistTaps="handled"
            onContentSizeChange={() =>
              scrollViewRef.current.scrollToEnd({ animated: true })
            }
          >
            <Text style={styles.date}>Hôm nay</Text>

            {messages.map((msg, index) => (
              <View
                key={index}
                style={
                  msg.sender === user.username
                    ? styles.userMessageContainer
                    : styles.systemMessageContainer
                }
              >
                <Text
                  style={
                    msg.sender === user.username
                      ? styles.userMessage
                      : styles.systemMessage
                  }
                >
                  {msg.message}
                </Text>
                <Text style={styles.time}>{formatTime(msg.time)}</Text>
              </View>
            ))}
          </ScrollView>

          <View style={styles.inputContainer}>
            <TextInput
              placeholder="Nhập nội dung tin nhắn"
              value={inputValue}
              onChangeText={setInputValue}
              style={styles.input}
              mode="outlined"
              outlineColor="transparent"
              activeOutlineColor="transparent"
              underlineColor="transparent"
              selectionColor="#f15c22"
            />
            <TouchableOpacity onPress={sendMessage}>
              <Icon
                source="send"
                size={26}
                color="#f15c22"
                style={styles.sendIcon}
              />
            </TouchableOpacity>
          </View>
        </View>
      </TouchableWithoutFeedback>
    </KeyboardAvoidingView>
  );
};

export default ChatBox;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#f6f6f6",
  },
  chatContainer: {
    flexGrow: 1,
    padding: 16,
    paddingBottom: 16,
  },
  date: {
    alignSelf: "center",
    backgroundColor: "#e4e4e4",
    paddingHorizontal: 12,
    paddingVertical: 4,
    borderRadius: 20,
    fontSize: 12,
    marginBottom: 12,
    color: "#555",
  },
  userMessageContainer: {
    alignSelf: "flex-end",
    backgroundColor: "#d2f8ce",
    padding: 10,
    borderRadius: 12,
    marginBottom: 10,
    maxWidth: "75%",
  },
  userMessage: {
    color: "#333",
    fontSize: 15,
    lineHeight: 20,
  },
  systemMessageContainer: {
    alignSelf: "flex-start",
    backgroundColor: "#ffffff",
    padding: 10,
    borderRadius: 12,
    marginBottom: 10,
    maxWidth: "85%",
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.06,
    shadowRadius: 2,
    elevation: 1,
  },
  systemMessage: {
    color: "#333",
    fontSize: 15,
    lineHeight: 20,
  },
  time: {
    fontSize: 11,
    color: "#888",
    marginTop: 4,
    textAlign: "right",
  },
  inputContainer: {
    flexDirection: "row",
    alignItems: "center",
    borderTopColor: "#ddd",
    borderTopWidth: 1,
    backgroundColor: "#fff",
    paddingHorizontal: 10,
    paddingVertical: 8,
  },
  input: {
    flex: 1,
    height: 42,
    borderRadius: 25,
    paddingHorizontal: 16,
    backgroundColor: "#f0f0f0",
    fontSize: 14,
  },
  sendIcon: {
    marginLeft: 8,
  },
});
