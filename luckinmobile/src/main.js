import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import nav from './components/nav.vue';
// 完整引入mint-ui库
import 'mint-ui/lib/style.css'
import MintUI from 'mint-ui'
import {Header} from 'mint-ui'
import '../lib/mui/css/mui.min.css'
import '../lib/mui/css/icons-extra.css'
// import {Header} from 'mint-ui'
// import '../lib/mui/js/mui.min.js'
import axios from 'axios'
// 配置跨域选项
axios.defaults.withCredentials=true;
axios.defaults.baseURL = 'http://127.0.0.1:3000/';
// // 
// axios.defaults.baseURL="http://127.0.0.1:3000/"
// 将axios配置到Vue实例中
Vue.prototype.axios = axios

Vue.config.productionTip = false
// 将mintui库中所有组件注册
Vue.use(MintUI)
// mint-ui 下的顶部
// Vue.component(Header.name,Header)
Vue.component('mt-header',Header)
Vue.component('my-nav',nav)

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
