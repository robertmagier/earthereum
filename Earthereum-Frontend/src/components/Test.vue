<template>

  <div class="test">
      <vue-up></vue-up>
    <input type="text" v-model="title"><br />
    <h1>{{title}}</h1>
    <p v-if="showName">{{user.firstName}}</p>
    <p v-else="showName">Nobody</p>
    <ul>
       <li v-for="item in items">Item: {{item.title}}</li>
    </ul>
    <button v-on:click="greet('John')">Say Greeting</button>
    <input type="text" v-on:keyup="pressKey" v-on:keyup.space="enterHit">
    <hr/>
    <label> First Name:</label><input type="text" v-model="user.firstName">
    <br />
    <label> Last Name:</label><input type="text" v-model="user.lastName">
    <h3>{{fullName}}</h3>
    <h2>{{msg}}</h2>
  </div>
</template>


<script>
import Vue from 'vue'
import VueUp from 'vueup'
Vue.use(VueUp)

  export default {
  name: 'test',
  props:  {
    msg:  {
      type: String,
      default:'Foobar'
    }
  },
  data() {
    return {
      title: 'Hello world mf',
      user: {
        firstName: 'John',
        lastName:'Doe'
      },
      showName: true,
      items: [
        {title: 'Item One'},
        {title: 'Item Two'},
        {title: 'Item Three'}
      ]

      }
    },
  methods:  {
    greet: function(greeting){
      this.$popup({message:"hello"})
      console.log("popup")
    },
    pressKey: function(e){
      console.log(e.target.value);
    },
    enterHit: function(){
      console.log("Enter");
    }
  },
  computed: {
    fullName: function(){
      return this.user.firstName+ ' ' + this.user.lastName;
    }
  }
  }
</script>

<style scoped>

</style>
