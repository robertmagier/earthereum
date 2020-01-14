<template>
<div id="CountryCard" v-bind:class="{continent:continent,world:world}" class="CountryCard ">

  <div class="country-title">
  {{tmpcountry.cname}}
    </div>
  <div class="country-description">
    <div>Language: {{tmpcountry.clang}}</div>
    <div> Currency: {{tmpcountry.ccur}}</div>
    <div> Popullation: {{tmpcountry.cpop}}</div>
    <div> President: {{tmpcountry.cpres}}</div>
    <div> Capital City: {{tmpcountry.ccap}}</div>
    <div :title="cownerlong" v-bind:class="{myCountry:myCountry,notMyCountry:!myCountry}">{{cowner}}</div>
    <div> <b>Price: {{tmpcountry.cprice}}</b> </div>
    <br/>
  </div>
  <div class="country-flag">
    <img :src="tmpcountry.cflag" alt="">
  </div>
  <div class="country-picture">
    <img :src="tmpcountry.cpic"  alt="">
  </div>

<b-button @click="testevent(tmpcountry.ccode)" style="margin:10px;border-radius:10px;" variant="primary"> Details </b-button>

</div>

</template>

<script>
// import cjson from '../../static/countries0.json'
import Vue from 'vue';
import VueResource from 'vue-resource'
import bButton from 'bootstrap-vue/es/components/button/button';
Vue.component('b-button', bButton);
import bTooltip from 'bootstrap-vue/es/components/tooltip/tooltip';
Vue.component('b-tooltip', bTooltip);

  export default {
  name: 'CountryCard',

    data() {
      return {
          newUser: {},
          users: [],
          countries:[],
          tmpcountry:{},
        }
      },
    props:  {
      ccode:'',
        country: {
          type:Object,
          default: () => ({})
        },

    },
    computed: {
      continent: function (){
        if (this.tmpcountry.ctype == 2)
        {
          return true;
        }
        else
        {
          return false;
        }
      },
      world: function (){
        if (this.tmpcountry.ctype == 3)
        {
          return true;
        }
        else
        {
          return false;
        }
      },
      myId: function()
      {
        return this.tmpcountry.ccode + '_cowner'
      },
      cowner: function ()
    {
      if (this.$store.state.web3account == this.tmpcountry.cowner) {
        return "You own it."
      }
      else return this.tmpcountry.cowner.substring(0,10)+"...";
    },
    myCountry: function () {
      return (this.$store.state.web3account == this.tmpcountry.cowner)
    },
      cownerlong: function ()
    {
      if (this.$store.state.web3account == this.tmpcountry.cowner) {
        return "You own it."
      }
      else return this.tmpcountry.cowner;;
    },
  },
    methods: {
      testevent(){
        var countryID = this.tmpcountry.ccode;
        // console.log('Obsluga w mapie');
        // console.log(countryID);
        this.$emit('testevent',countryID)

      },
    },
    created: function(){
      let tmp;
      if(this.country != undefined) {
        this.tmpcountry = this.country;
        // console.log(this.tmpcountry.cflag)
        // console.log(this.tmpcountry.cpic)
        this.tmpcountry.cflag=this.$config.API+'/getFlag?ccode='+this.tmpcountry.ccode;
        this.tmpcountry.cpic=this.$config.API+'/getCountryPicture?ccode='+this.tmpcountry.ccode;

        // console.log(this.tmpcountry.cname)
        // console.log(this.tmpcountry.cflag)
      }
      if(this.ccode != undefined)
      {
        let cod = this.ccode;
        //console.log(this.ccode)
        this.$http.get(this.$config.API+'/getCountries').then(function(response){
        // this.$http.get('/static/countries0.json').then(function(response){
      // console.log(response.data);
      //  this.countries = response.data;
        // console.log('Szukam')
        // console.log(this);
        tmp = response.data.find(function(obj){return obj.ccode==cod})
        // console.log(tmp);
        this.tmpcountry = tmp;
        this.tmpcountry.cflag=this.$config.API+'/getFlag?ccode=' + this.tmpcountry.ccode
        this.tmpcountry.cpic=this.$config.API+'/getCountryPicture?ccode='+this.tmpcountry.ccode;


      })
        this.tmpcountry.cflag=this.$config.API+'/getFlag?ccode=' + this.tmpcountry.ccode

    }
    },
    watch : {
      ccode(val) {
        // console.log("Zmiana w CountryCode");
      },
      country(val) {
        // console.log("Zmiana Kraju");
        this.tmpcountry = val;
      }

    }
}
</script>

<style scoped>
@import '../style2.css';

.continent:hover {
  background-color:rgb(255,215,0);
}
.continent {
  background-color:rgb(43,105,120);
}
.world {
  background-color:rgb(176,255,28);
}
.world:hover {
  background-color:rgb(73,184,110);
}

.myCountry {
  background-color:#24D330;
  font-weight:600;
  font-size:12px;
  margin:0px;
  text-align: center;
  /* padding:4px; */
  border-radius:5px;
  text-shadow: 0px 0px 0px #000;
  width:80%;
}

.notMyCountry {
  /* background-color:rgba(200,0,0,0.7); */
  font-weight:600;
  font-size:12px;
  margin:0px;
  text-align: left;
  /* padding:10px 0px; */
  border-radius:5px;
  text-shadow: 0px 0px 0px #000;
}


</style>
