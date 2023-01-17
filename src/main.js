import Vue from 'vue'
import App from './App.vue'
import ElementUI from 'element-ui'
import router from './router'
import 'element-ui/lib/theme-chalk/index.css';

// 添加一键复制
import VueClipboard from 'vue-clipboard2';
Vue.use(VueClipboard);


// axios挂载
import httpRequest from './http/index'
Vue.prototype.httpRequest = httpRequest

Vue.config.productionTip = false
Vue.use(ElementUI);
new Vue({
  router,
  render: h => h(App),
}).$mount('#app')
