import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../views/authViews/Login'
import Main from '../views/Main'
import UserList from "@/views/userViews/UserList";
import SystemIndex from "@/views/SystemIndex";
import { Message } from 'element-ui'
import Register from "@/views/authViews/Register";
import Reset from "@/views/authViews/Reset";
import RoleList from "@/views/userViews/RoleList";
import PermissionList from "@/views/userViews/PermissionList";
import NoPath from "@/views/404"
import FileList from "@/views/storageViews/FileList"
import ImageList from "@/views/storageViews/ImageList"
import AudioList from "@/views/storageViews/AudioList"
import VideoList from "@/views/storageViews/VideoList"
import MenuList from "@/views/userViews/MenuList"
import Resource from "@/views/userViews/Resource";

// 自己定义的请求包。只能在组件中使用，如果非要在这里使用，必须引入

Vue.use(VueRouter)



const routes = [
  {
    path: '/',
    name: 'login',
    meta:{
      isExist:true
    },
    component: Login
  },
  {
    path: "/register",
    name: "register",
    component: Register
  },
  {
    path: "/reset",
    name: "reset",
    component: Reset
  },
  {
    path: '/main',
    name: 'main',
    component: Main,
    children: [
      {
        path: '/index',
        name: 'systemIndex',
        component: SystemIndex
      },
      {
        path: '/user/permissionList',
        name: 'permissionList',
        meta: {
          isLogin: true
        },
        component: PermissionList
      },
      {
        path: '/user/roleList',
        name: 'roleList',
        meta: {
          isLogin: true
        },
        component: RoleList
      },
      {
        path: '/user/userList',
        name: 'userList',
        meta: {
          isLogin: true
        },
        component: UserList
      },
      {
        path: '/user/menuList',
        name: 'menuList',
        meta: {
          isLogin: true
        },
        component: MenuList
      },
      {
        path: '/user/resource',
        name: 'resource',
        meta: {
          isLogin: true
        },
        component: Resource
      },

      {
        path: '/storage/fileList',
        name: 'fileList',
        meta: {
          isLogin: true
        },
        component: FileList
      },
      {
        path: '/storage/imageList',
        name: 'imageList',
        meta: {
          isLogin: true
        },
        component: ImageList
      },
      {
        path: '/storage/videoList',
        name: 'videoList',
        meta: {
          isLogin: true
        },
        component: VideoList
      },
      {
        path: '/storage/audioList',
        name: 'audioList',
        meta: {
          isLogin: true
        },
        component: AudioList
      }




    ]
  },
  {
    path: '*',
    name: '404',
    meta:{
      isLogin:true
    },
    component: NoPath
  },
]

const router = new VueRouter({
  routes
})

//全局前置守卫：初始化时执行、每次路由切换前执行
router.beforeEach((to,from,next) =>{

  if (to.meta.isExist){
    if (localStorage.getItem("token") == null){
      next()
    }else{
      next({
        path: '/index'
      })
    }
  }


  if(to.meta.isLogin){ //判断当前路由是否需要进行权限控制
    // console.log(store.state.user)
    if (localStorage.getItem("token") == null){
      Message.info("请先登录")
      next({
        path: '/index',
      })
    }
    next()
  }else{
    next() //放行
  }
})

// //全局后置守卫：初始化时执行、每次路由切换后执行
// router.afterEach((to,from)=>{
//   console.log('afterEach',to,from)
//   if(to.meta.title){
//     document.title = to.meta.title //修改网页的title
//   }else{
//     document.title = 'vue_test'
//   }
// })

/* 解决导航重复问题 */
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push (location) {
  return originalPush.call(this, location).catch(err => err)
}


export default router
