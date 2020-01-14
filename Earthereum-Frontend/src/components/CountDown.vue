<style lang="css">

.timer-box-header {
    grid-column: 1/5;
    text-align: center;
    /* border-style:solid; */
    color: #fafafa;
    border-color: black;
    text-transform: uppercase;
    font-size: 16px;
    font-weight: 700;
}

.timer-box {
    max-width: 324px;
    width: auto;
    /* display:grid; */
    /* grid-template-columns: auto; */
    transform: scale(auto);
    /* margin:10px; */
    /* border-style:solid; */
    /* border-color:white; */
    /* border-width:2px; */
}

.timer {
    display: grid;
    grid-gap: 5px;
    width: auto;
    grid-template-columns: auto auto auto auto;
    /* background-color: #F0F2F1; */
    /* padding:10px 7px 2px 7px; */
    border-radius: 5px;
    /* border-style:solid; */
}

.peace {
    background-color: #28A745;
}

.alliance {
    background-color: #FFC107;
}

.war {
    background-color: #D90C1D;
}

.timer-group {
    display: grid;
    grid-template-columns: 1fr auto auto 1fr;
    grid-gap: 3px;
    /* border-style:solid; */
}

.timer-header {
    grid-column: 1/5;
    color: #fafafa;
    font-size: 8px;
    font-weight: 700;
    /* border-style:solid; */
    text-align: center;
    margin: 3px;
}

.value {
    text-align: center;
    border-style: none;
    padding: 1px 2px;
    height: 20px;
    width: 15px;
    border-width: 1px;
    /* width:40px; */
    font-size: 14px;
    /* background: linear-gradient(135deg, black, red 120%); */
    background-color: #424342;
    ;
    border-radius: 3px;
    /* margin:5px; */
    box-shadow: 1px 1px 1px 1px #333;
}

</style>

<template lang="">

<div class="timer-box">

    <div></div>
    <div class="timer" v-bind:class="worldstate">
        <div class="timer-box-header" v-bind:class="{blink:switching}">
            {{title}}
            <!-- <p  v-if="worldstate=='peace'">{{peaceRange}}%</p> -->
            <b-progress :variant="variant" height="30px" style="border-style:solid;border-width:1px;background-color:white;border-color:#777;margin:5px;font-weight:400;"  :value="progressValue"  :precision="2" :max="max"  >
              <b-progress-bar style="color:#222;font-weight:700;" :label="progressValue.toFixed(2) + '%'" :value="progressValue">

              </b-progress-bar>
            </b-progress>


            <!-- <p style="font-size:18px;" v-if="worldstate!='peace'">{{timeRangePer}}%</p> -->
            <!-- <b-progress v-if="worldstate!='peace'" style="margin:5px;" show-progress :precision="2" :value="timeRangePer" :max="max"  ></b-progress> -->
            <!-- <p v-if="worldstate=='peace'">TS: {{timeRangePer}}% WP: {{warPoolRange}}% Min: {{peaceRange}}%</p> -->
        </div>

        <div v-if="admin" class="timer-group">
            <div></div>
            <div class="value">
                {{Days1}}
            </div>
            <div class="value">
                {{Days2}}
            </div>
            <div></div>

            <div class="timer-header">
                DAYS
            </div>
        </div>
        <div  v-if="admin" class="timer-group">
            <div></div>
            <div class="value">
                {{Hours1}}
            </div>
            <div class="value">
                {{Hours2}}
            </div>
            <div></div>
            <div class="timer-header">
                HOURS
            </div>
        </div>
        <div  v-if="admin" class="timer-group">
            <div></div>
            <div class="value">
                {{Minutes1}}
            </div>
            <div class="value">
                {{Minutes2}}
            </div>
            <div></div>
            <div class="timer-header">
                MINUTES
            </div>
        </div>
        <div  v-if="admin" class="timer-group">
            <div></div>
            <div class="value">
                {{Seconds1}}
            </div>
            <div class="value">
                {{Seconds2}}
            </div>
            <div></div>
            <div class="timer-header">
                SECONDS
            </div>
        </div>

    </div>
    <div></div>
</div>

</template>

<script>
import Vue from 'vue';

import bProgress from 'bootstrap-vue/es/components/progress/progress';
import bProgressBar from 'bootstrap-vue/es/components/progress/progress-bar';
Vue.component('b-progress', bProgress);
Vue.component('b-progress-bar', bProgressBar);

export default {

    data() {
            return {
                countdown: {},
                timer: {},
                timerStartedAt: Date.now(),
                timerCurrentTime: Date.now(),

                Seconds1: 0,
                Seconds2: 0,
                Days1: 0,
                Days2: 0,
                Hours1: 0,
                Hours2: 0,
                Minutes1: 0,
                Minutes2: 0,
                warpoolLimit: 2,
                warPoolRange: 0,
                peaceRange: 0,
                timeRangePer: 0,
                countDown: '',
                timerRunning: false,
                switching:false,


            }
        },
        props: {
          admin: false
        },
        created: function() {
            var worldstate = this.$store.state.worldstate;
            if (worldstate == 'war') this.war = true;
            if (worldstate == 'peace') this.peace = true;
            if (worldstate == 'alliance') this.alliance = true;
            this.peacehours = this.$store.state.peacehours;
            this.peacedays = this.$store.state.peacedays;
            // this.alliancehours = this.$store.state.alliancehours;
            // this.alliancedays = this.$store.state.alliancedays;
            // this.warhours = this.$store.state.warhours;
            // this.wardays = this.$store.state.wardays;
            // this.timeLimit = this.$store.state.timeLimit;
            this.warpoolLimit = this.$store.state.warpoollimit;
            // this.startCountDown();
            // this.updateTime();
            this.doTheTime();
        },
        computed: {
            variant: function (){
              if (this.worldstate ==  'peace')
              {
                return 'success'
              }
              if (this.worldstate ==  'alliance')
              {
                return 'warning'
              }
              if (this.worldstate ==  'war')
              {
                return 'danger'
              }

            },
            progressValue: function ()
            {
              if (this.worldstate == 'peace')
              {
                return this.peaceRange;
              }
              else {
                // console.log(this.timeRangePer)
                // console.log('TimeRangePer')
                return this.timeRangePer;
              }
            },
            max: function  ()
            {
              return 100;
            },
            title: function() {
              if ( this.$store.state.worldstate == 'alliance' ) return "alliance/defense"
              else return this.$store.state.worldstate;
            },
            worldstate: function() {
              return this.$store.state.worldstate;
            },
            timeLimit: function (){
              return this.$store.state.timeLimit;
            },
            timeStart: function (){
              return this.$store.state.timeStart;
            }

        },
        watch: {
          // stimeLimit: function(val)
          // {
          //   console.log('timeLimitChanged ' + val)
          //   this.timeLimit = val;
          // },
          // timeStart: function (val)
          // {
          //   console.log('timeStartChanged ' + val)
          //
          //   this.timeStart = val;
          // }
        },
        methods: {
            doTheTime: function() {
                var that = this;
                this.$store.state.timerRunning++;
                var timernumber = this.$store.state.timerRunning;

                var localtimer = setInterval(function() {
                    // console.log(timernumber + " ? " + that.$store.state.timerRunning)
                    if (timernumber < that.$store.state.timerRunning) {
                        // console.log('stopping myself');
                        clearInterval(localtimer);
                        return;
                    }
                    // console.log('interval')
                    that.timerCurrentTime = Date.now();
                    that.warpoolLimit = that.$store.state.warpoollimit;
                    var seconds = that.timeLimit - Math.round(that.timerCurrentTime / 1000);
                    seconds = Math.max(0, seconds);

                    var timeRange = that.timeLimit - that.timeStart;
                    if (timeRange != 0) {
                        that.timeRangePer = parseFloat(100 - (seconds / timeRange) * 100);
                    } else {
                        that.timeRangePer = 100;
                    }
                    if (that.warpoolLimit > 0) {
                        that.warPoolRange = parseFloat(((that.$store.state.warpool / that.warpoolLimit)) * 100);
                    } else {
                        that.warPoolRange = 100;
                    }
                    that.peaceRange = Math.min(that.warPoolRange, that.timeRangePer)
                    that.peaceRange = Math.min(100, that.peaceRange);

                    if(that.worldstate=='peace' && that.peaceRange==100)
                    {
                      that.switching=true;
                    }
                    else {
                      that.switching=false;
                    }
                    if(that.worldstate !='peace') {

                      if (that.timeRangePer == 100)
                      {
                        that.switching = true;
                      }
                      else {
                        that.switching = false;
                      }
                    }
                    // console.log(that.countDown);
                    // console.log(seconds);
                    var days = Math.floor(seconds / (3600 * 24));
                    seconds -= days * 3600 * 24;
                    var hrs = Math.floor(seconds / 3600);
                    seconds -= hrs * 3600;
                    var mnts = Math.floor(seconds / 60);
                    seconds -= mnts * 60;

                    that.Days2 = days % 10;
                    that.Days1 = (days - that.Days2) / 10;

                    that.Hours2 = hrs % 10;
                    that.Hours1 = (hrs - that.Hours2) / 10;

                    that.Minutes2 = mnts % 10;
                    that.Minutes1 = (mnts - that.Minutes2) / 10;

                    that.Seconds2 = seconds % 10;
                    that.Seconds1 = (seconds - that.Seconds2) / 10;


                }, 1000);
            }
        }
}

</script>
