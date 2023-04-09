import axios from "axios"
import { Message } from 'element-ui'

// axios.defaults.baseURL = 'http://localhost:8080'
// axios.defaults.headers.common["Authorization"] = "hahah"

// 创建axios实例
var instance =  axios.create({
    baseURL: 'http://nobibibi.top:5000/', // 添加基本地址
    timeout: 50000, // 所有请求在超时前等待1秒
})

export default instance
