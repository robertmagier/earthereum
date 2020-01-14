<template>
<div id="ammap" class="main-nav">
  <div class="main-nav-header">
    <a href=""><img src="../img/logo.png" style="width:150px;" alt=""></a>
  </div>
  <div class="main-nav-links">
    <ul>
      <li> <a href="#">ADMINISTRATION</a> </li>
      <li> <a href="">WORLD MAP</a> </li>
      <li> <a href="#">MY OPERATION</a> </li>
      <li> <a href="#">FAQ</a> </li>
    </ul>
  </div>
</div>

</template>


<script>
  export default {
  name: 'ammap',

    data() {
      return {
          newUser: {},
          users: []
        }
      },
    props:  {
        cname:  {
          type: String,
          default:'Foobar'
        },
        cdescription:  {
          type: String,
          default:'Foobar'
        },
        flag:  {
          type: String,
          default:'Foobar'
        },
        picture:  {
          type: String,
          default:'Foobar'
        },

    },
    methods:  {
      addUser: function (e){
        this.users.push({
          name: this.newUser.name,
          email:this.newUser.email,
          contacted:false
        });
        // console.log('add');
        e.preventDefault();

      },

      deleteUser: function(user){
        this.users.splice(this.users.indexOf(user),1)
      }

      },
      created: function(){
        // console.log('created ran....');
        // this.$http.get('https://jsonplaceholder.typicode.com/users')
        // .then(function(response){
        //   this.users = response.data;
        // });
      },
    computed: {

      }
}
</script>

<style>
@import '../style2.css';
</style>
