import axios from "axios"
import { Message } from 'element-ui'

// axios.defaults.baseURL = 'http://localhost:8080'
// axios.defaults.headers.common["Authorization"] = "hahah"

// 创建axios实例
var instance =  axios.create({
    baseURL: 'http://nobibibi.top:5000/', // 添加基本地址
    // baseURL: 'http://127.0.0.1:5000/', // 添加基本地址
})

export default instance
