// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import vueRouter from 'vue-router'
import vueResource from 'vue-resource'
import App from './App'
import Users from './components/Users'
import Test from './components/Test'
import CountryCard from './components/CountryCard'
// import Map from './components/Map'
import Menu from './components/Menu'
import Footer from './components/Footer'
import WarRoom from './components/WarRoom'
import TestMap from './components/TestMap'
import VectorMap from './components/VectorMap'
import News from './components/News'
import WarPool from './components/WarPool'
import About from './components/about'
import Administration from './components/Administration'
import Faq from './components/faq'
import ManyCountries from './components/ManyCountries'
import Ranking from './components/Ranking'
import MyOperation from './components/MyOperation'
import Web3Test from './components/Web3Test'
// require ("easytimer/dist/easytimer.min.js")
import TestStorage from './components/TestStorage'
import {
  store
} from './storage/store'
var styleLoader = require("style-loader")
import './style2.css'
Vue.config.productionTip = false
Vue.config.productionTip = false
Vue.use(vueResource)
Vue.use(vueRouter)
import axios from 'axios'
import vueAxios from 'vue-axios'
Vue.use(axios);

const vueConfig = require('vue-config')
const configs = {
  API: 'https://flask-backend-api.herokuapp.com'
  // API: 'http://localhost:5000'
}

Vue.use(vueConfig, configs)

const router = new vueRouter({
  mode: 'history',
  base: __dirname,
  routes: [{
      path: '/',
      component: About
    },
    {
      path: '/admin',
      component: Administration
    },
    {
      path: '/web3test',
      component: Web3Test
    },
    {path:'/myoperation', component: MyOperation},
    {
      path: '/about',
      component: About
    },
    {
      path: '/faq',
      component: Faq
    },
    {
      path: '/test',
      component: TestStorage
    },
    {
      path: '/statistics',
      component: Administration
    },
    {
      path: '/map',
      component: WarRoom
    }

  ]
})


/* eslint-disable no-new */
new Vue({
  router,
  // el: '#app',
  store: store,
  created: function() {
    // console.log('readCountries');
    // console.log(axios);
    store.commit('readCountries');
    // store.commit('updatePrices');
    // store.commit('Alliance');
  },
  components: {
    Menu,
    Footer,
    CountryCard,
    WarRoom,
    News,
    About,
    ManyCountries,
    TestStorage
  },
  template: `
    <div id="app" class="app wrapper">
    <Menu/>
    <router-view></router-view>
    <Footer/>
  </div>
  `
  // template: `
  //         <div id="app">
  //         <Menu></Menu>
  //         <ul>
  //           <li><router-link to="/">Usersss</router-link></li>
  //           <li><router-link to="/test">Test</router-link></li>
  //           <li><router-link to="/app">App</router-link></li>
  //         </ul>
  //         <router-view></router-view>
  //         </div>
  //
  // `
}).$mount('#app');

Vue.filter('two_digits', function(value) {
  if (value.toString().length <= 1) {
    return "0" + value.toString();
  }
  return value.toString();
});

Vue.filter('truncate', function (text, stop, clamp) {
    return text.slice(0, stop) + (stop < text.length ? clamp || '...' : '')
});

Vue.filter('uppercase', function (text) {
    return text.toUpperCase();
});
