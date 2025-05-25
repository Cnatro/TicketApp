// import { BASE_URL } from '@env';
import axios from "axios";

export const endpoints = {
    "events" : "/events/"
};

const BASE_URL = "http://192.168.1.106:8000";
console.log("BASE_URL:", BASE_URL);

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