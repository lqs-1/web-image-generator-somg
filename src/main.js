import Vue from 'vue'
import router from './router'


// 引入ElementUi
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
Vue.use(ElementUI);

// 引入视频播放模块
import VueCoreVideoPlayer from 'vue-core-video-player'
Vue.use(VueCoreVideoPlayer)


// 引入echarts
import echarts from 'echarts'
Vue.prototype.$echarts = echarts

// 添加一键复制
import VueClipboard from 'vue-clipboard2';
Vue.use(VueClipboard);

// axios挂载
import httpRequest from './http/index'
Vue.prototype.httpRequest = httpRequest

// 导入vuex
import store from "@/store";


Vue.config.productionTip = false

import App from './App.vue'

new Vue({
  router,
  render: h => h(App),
  store
}).$mount('#app')
