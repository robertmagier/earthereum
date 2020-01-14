<style scoped>

@import '../style2.css';
.warcolor {
    background-color: rgba(255, 0, 0, 0.35);
}
.alliancecolor {
    background-color: rgba(255,255, 0, 0.3);

}
.peacecolor {
    background-color: rgba(0,255,0, 0.2);

}

</style>

<template>

<div id="Map" class="Map map-section">


    <!-- NAVIGATION -->
    <!-- MAP CONTAINER -->
    <div class="map-container">
        <div class="empty-box">

        </div>
        <Warning></Warning>


        <!-- WAR POOL INFORMATION -->
        <News></News>
        <!-- GAME NEWS -->

        <WarPool class="card-content card-warpool"></WarPool>

        <CountDown class="card-timer" />

        <div class="card-map card-content" v-bind:class="{warcolor:warcolor,alliancecolor:alliancecolor,peacecolor:peacecolor}" style="height:400px; width:auto;">
            <VectorMap v-on:testevent="testevent($event)"></VectorMap>
        </div>
    </div>


</div>

</template>

<script>

import vueResource from 'vue-resource'
import Vue from 'vue'
import VueUp from 'vueup'
import CountDown from './CountDown'
import VectorMap from './VectorMap'
import CountryCard from './CountryCard'
import News from './News'
import Warning from './Warning'
import WarPool from './WarPool'

Vue.use(VueUp)

export default {
    name: 'Map',
    components: {
        Map, CountDown, CountryCard, VectorMap, News, WarPool,Warning
    },
    data() {
        return {
            newUser: {},
            users: [],
            countdown: 'test',
            robertmagier: '',
            timer: {}
        }
    },
    props: {

    },
    methods: {
        testevent(countryID) {
                // console.log('Obsluga w mapie');
                // console.log(countryID);
                this.$emit('testevent', countryID)

            },
            updateTime: function() {
                //console.log("UpdateTime");
                this.countdown = this.timer.getTimeValues().toString(['days', 'hours', 'minutes', 'seconds']);
                this.countdown = "D:" + this.timer.getTimeValues().days + " H:" + this.timer.getTimeValues().hours + " M:" + this.timer.getTimeValues().minutes + " S:" + this.timer.getTimeValues().seconds;
                //console.log(this.countdown);
                setTimeout(this.updateTime, 1000);
            }
    },

    computed: {
        warcolor: function() {
            return this.$store.state.worldstate == 'war'
        },
        alliancecolor: function() {
            return this.$store.state.worldstate == 'alliance'
        },
        peacecolor: function() {
            return this.$store.state.worldstate == 'peace'
        }
    },
    created: function() {
        var Timer = require("easytimer/dist/easytimer.min.js");
        // this.timer = new Timer();
        // console.log("Timer");
        // console.log(this.timer);
        // var counter="Test";
        // this.timer.start({precision: 'secondTenths',countdown: true, startValues: {seconds: 3000000}});
        // this.timer.addEventListener('minutesUpdated', function (e) {

        // this.countdown = (timer.getTimeValues().toString(['days','hours', 'minutes', 'seconds']));
        // });
        // this.timer.addEventListener('targetAchieved', function (e) {
        // });
        // this.updateTime();
    }
}

</script>
