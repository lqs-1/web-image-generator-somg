//引入Vue核心库
import Vue from 'vue'
//引入Vuex
import Vuex from 'vuex'
//应用Vuex插件
Vue.use(Vuex)
/**
 * 这个vuex没有用
 * @type {{}}
 */


//准备actions对象——响应组件中用户的动作
const actions = {}
//准备mutations对象——修改state中的数据
const mutations = {
    // 在vuex中存储token
    STORAGE_TOKEN(state, token){
        localStorage.setItem("token", token)
        state.token = token
    },
    // 填充vuex中的username
    STORAGE_USER_NAME(state, username){
        localStorage.setItem("username", username)
        state.user = username
    },

    // 退出登录的时候清除username和token
    CLEAN_LOGIN_DATA(state){
        localStorage.clear()
        state.token = null;
        state.username = null;
    }
}
//准备state对象——保存具体的数据
const state = {
    username: null,
    token: null
}

//创建并暴露store
let store = new Vuex.Store({
    actions,
    mutations,
    state
})

export default store
