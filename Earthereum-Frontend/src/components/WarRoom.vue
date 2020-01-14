<style scoped>

@import '../style2.css';

</style>

<template>

<div id="WarRoom">

    <CountryDetails  :active="activeDetails" :ccode="popupCcode" v-on:testevent="testevent($event)" class="popup" />



    <Map v-on:testevent="testevent($event)"></Map>
    <ManyCountries v-on:testevent="testevent($event)" :onlyOwned="false"></ManyCountries>
</div>

</template>

<script>

import vueResource from 'vue-resource'
import ManyCountries from './ManyCountries'
import CountryDetails from './CountryDetails'
import {
    store
}
from '../storage/store'

import Map from './Map'
export default {
    name: 'WarRoom',
    components: {
        Map, ManyCountries, CountryDetails
    },
    data() {
        return {
            newUser: {},
            users: [],
            popupInVisible: true,
            popupCcode: '',
            activeDetails:false
        }
    },
    props: {
        cname: {
            type: String,
            default: 'Foobar'
        },
        cdescription: {
            type: String,
            default: 'Foobar'
        },
        flag: {
            type: String,
            default: 'Foobar'
        },
        picture: {
            type: String,
            default: 'Foobar'
        },

    },
    methods: {
        escape: function() {
            // console.log("Escape");
        },
        addUser: function(e) {
            this.users.push({
                name: this.newUser.name,
                email: this.newUser.email,
                contacted: false
            });
            // console.log('add');
            e.preventDefault();

        },
        testevent: function(ccode) {
            // console.log('obsluga-zdarzenia War Room')
            this.popupCcode = ccode;
            // console.log(ccode);
            // this.popupInVisible = !this.popupInVisible;
            // this.$refs.CountryDetails.show()
            this.activeDetails = !this.activeDetails;

        },
        deleteUser: function(user) {
            this.users.splice(this.users.indexOf(user), 1)
        },
        zdarzenie: function() {
            // console.log('zdarzenie')
        }
    },
    created: function() {
        // console.log('created ran...WarRoom.');

    },
    events: {

    },
    computed: {

    }

}

</script>
