// import { BASE_URL } from '@env';
import axios from "axios";


const BASE_URL = "http://192.168.1.109:8000";


export const endpoints = {
    "events" : "/events/",
    "categories" : "/categories/"
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