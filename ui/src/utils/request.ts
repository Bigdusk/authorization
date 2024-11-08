import axios from "axios";
const axios_util = axios.create({
    baseURL: "/dev",
    timeout: 60000
});

interface ApiResponse<T> {
    code: number,
    message: string,
    data: T
}

//请求拦截器
axios_util.interceptors.request.use(
    config => {
        config.headers.Authorization = localStorage.getItem('authorization')
        return config;
    },
    error => {
        return Promise.reject(error);
    }
)

axios_util.interceptors.response.use(
    response => {
        return response.data;
    },
    error => {
        return Promise.reject(error);
    }
)


//要求实现参数提示
//封装get方法
export async function get<T>(
    url: string,
    params?: any
): Promise<T> {
    return await axios_util.get<ApiResponse<T>>(url, { params })
        .then(response => {
            return response.data
        })
        .catch(error => {
            return error
        })
}

//封装post请求
export async function post<T>(
    url: string,
    data: any,
    params?: any
): Promise<T> {
    return await axios_util.post<ApiResponse<T>>(url, data, { params })
        .then(response => {
            return response.data
        })
        .catch(error => {
            return error
        })
}