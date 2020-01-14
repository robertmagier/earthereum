<template>
<div id="MyOperation" class="CountryCards">
  <CountryDetails  :active="activeDetails" :ccode="popupCcode" v-on:testevent="testevent($event)" class="popup" />

  <div class="countries-cards">
    <transition name="fade">


    </transition>
    <ManyCountries v-on:testevent="testevent($event)" :onlyOwned="true"></ManyCountries>


  </div>
</div>
</template>

<script>
import Vue from 'vue'
import CountryCard from "./CountryCard"
import CountryDetails from "./CountryDetails"
import ManyCountries from "./ManyCountries"
import bTable from 'bootstrap-vue/es/components/table/table';
Vue.component('b-table', bTable);
import bPagination from 'bootstrap-vue/es/components/pagination/pagination';
Vue.component('b-pagination', bPagination);

export default {
  name: 'MyOperation',
  data() {
    return {
      newUser: {},
      users: [],
      countries: [],
      country: {},
      popupInVisible: true,
      popupCcode: '',
      activeDetails:false
      
    }
  },
  methods: {
    testevent: function(ccode) {
        // console.log('obsluga-zdarzenia War Room')
        this.popupCcode = ccode;
        // console.log(ccode);
        // this.popupInVisible = !this.popupInVisible;
        // this.$refs.CountryDetails.show()
        this.activeDetails = !this.activeDetails;

    },
  },

  components: {
    CountryCard,
    ManyCountries,
    CountryDetails
  },
    created: function() {
    this.$http.get('/static/countries.json').then (function(response) {
      this.countries = response.data;
      this.country = this.countries[2];
    });
  }
}
</script>

<style scoped>
@import '../style2.css';
</style>
