import Vue from 'vue'
import router from './router'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'


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

Vue.use(ElementUI);

new Vue({
  router,
  render: h => h(App),
  store
}).$mount('#app')
