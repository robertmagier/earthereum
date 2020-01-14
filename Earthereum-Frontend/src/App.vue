<template>
  <div id="app" class="wrapper">
  <Menu/>
  <router-view></router-view>
  <Footer/>
</div>
</template>

<script>

import vueRouter from 'vue-router'
import vueResource from 'vue-resource'
import Test from './components/Test'
import Users from './components/Users'
import CountryCard from './components/CountryCard'
import Menu from './components/Menu'
import Footer from './components/Footer'


export default {
  name: 'App',
  components: {
    Test,Users,CountryCard,Menu,Footer,Map
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 0px;
}
</style>
