import Vue from 'vue'
import Router from 'vue-router'
import Eor from './views/eor'
import Index from './views/index'
import Menu from './views/menu'
import Order from './views/order'
import oDetails from './views/order_details'
import Shopping from './views/shopping'
import User from './views/user'
import Scro from './views/scrol.vue'

Vue.use(Router)

export default new Router({
  routes: [
    { path: '/Scro', component: Scro },
    { path: '/User', component: User },
    { path: '/Shopping', component: Shopping },
    { path: '/Details/:id', component: oDetails,props:true },
    { path: '/Order', component: Order },
    { path: '/Menu', component: Menu },
    { path: '/Index', component: Index },
    { path: '/', component: Index },
    { path: '*', component: Eor }
    // {
    //   path: '/',
    //   name: 'home',
    //   component: Home
    // },
  ]
})
