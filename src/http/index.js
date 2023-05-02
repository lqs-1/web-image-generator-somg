import axios from "axios"
import { Message } from 'element-ui'

// axios.defaults.baseURL = 'http://localhost:8080'
// axios.defaults.headers.common["Authorization"] = "hahah"

// 创建axios实例
var instance =  axios.create({
    // baseURL: 'http://nobibibi.top:8888/', // 添加基本地址
    baseURL: 'http://localhost:8888/', // 添加基本地址
    // timeout: 50000, // 所有请求在超时前等待1秒
    // headers: {'Authorization': 'hehe'}, // 添加请求头
    // withCredentials: true, // 请求的时候携带cookie header
})



// 添加请求拦截器
instance.interceptors.request.use(function (config) {
    // 在请求之前做些什么,config对象是请求的属性，请求头数据，请求参数等等
    if (localStorage.getItem("token") != null){
        config.headers['token'] = localStorage.getItem("token");
    }
    return config
}, function (error) {
    // 在请求错误的时候做些什么,不用太关注，不常用，我也不知道干啥的
    return Promise.reject(error)
})


// 添加相应拦截器，可以在这里做请求成功或者失败的提示
instance.interceptors.response.use(function (response) {
    // 对响应的数据做些什么, response就是整个响应
    // 表示请求是成功的
    if (response.status && response.status == 200){
        // 表示后台响应的状态也是成功状态
        console.log(response.headers['auth'])
        if (response.headers['auth'] != null){
            localStorage.setItem("token", response.headers['auth'])
        }
        if (response.data.code == 11001){
            localStorage.setItem("menus", JSON.stringify(response.data.menus))
        }

        if (response.data.code == 21037){
            Message.error(response.data.msg)
            localStorage.clear()
            location.replace("/")
            return ;
        }

        if (response.data.code == 0 || (response.data.code >= 10000 && response.data.code < 20000) || response.data.code == 1000){
            Message.success(response.data.msg)
            return response;
        }else if(response.data.code > 20000){
            Message.error(response.data.msg)
            return ;
        }else{
            Message.info(response.data.msg)
            return ;
        }
        return ;

    }else{
        // 表示请求是失败的
        Message.error("请求失败")
        return ;
    }
    return response;
}, function (error) {
    // 对响应错误做些什么,服务器内部的错误才会触发比如，404,403,500等等
    Message.error("请求失败")
    return ;
})

export default instance

