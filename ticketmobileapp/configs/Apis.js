// import { BASE_URL } from '@env';
import axios from "axios";


const BASE_URL = "http://192.168.1.111:8000";


export const endpoints = {
    "events" : "/events",
    "categories" : "/categories",
    "login":"/o/token/",
    "register":"/users/",
    "current-user":"/users/current-user/"
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