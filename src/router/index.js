import Vue from 'vue'
import VueRouter from 'vue-router'
import localImageUpload from '../views/LocalImageUpload'


// 自己定义的请求包。只能在组件中使用，如果非要在这里使用，必须引入

Vue.use(VueRouter)



const routes = [
    {
        path: '/',
        name: 'localImageUpload',
        component: localImageUpload
    },
]

const router = new VueRouter({
    routes
})



export default router
