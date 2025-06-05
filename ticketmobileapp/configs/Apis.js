// import { BASE_URL } from '@env';
import axios from "axios";


const BASE_URL = "http://192.168.1.112:8000";

export const webSocketUrl = `ws://192.168.1.112:8000/ws/chat`
export const endpoints = {
    "events" : "/events",
    "categories" : "/categories",
    "login":"/o/token/",
    "register":"/users/",
    "current-user":"/users/current-user/",
    "receipt" :"/receipts",
    "paypal" :"/paypal",
    "chat-room" :"/chatroom/room-messages/",
    "send-email" :"/email/send/"
};

export const authApis = (token) => {
    return axios.create({
        baseURL: BASE_URL,
        headers: {
            'Authorization': `Bearer ${token}`
        }
    })
}

export default axios.create({
    baseURL: BASE_URL
});