<style scoped>

.timediv {
    display: grid;
    grid-template-columns: auto auto auto auto auto 1fr;
    align-items: top;
    margin: 10px 0px;
    grid-gap: 10px;
}

.bg-light {
    background-color: rgba(0, 0, 0, 0);
}

.bold {
    font-weight: 800;
    opacity: 1;
    color: #fafafa;
}

.bold:hover {
    color: #fafafa;
}

.form-control {
    font-size: 12px;
}

.card {
    background-color: rgba(0, 0, 0, 0.8) !important;
    font-size: 16px;
    color: #fafafa;
}

.opaque {
    transition: opacity 0.3s, color 0.3s;
    opacity: 0.7;
    font-weight: 800;
    color: #333;
}

.opaque:hover {
    opacity: 1;
    color: #aaa;
}

.nav {}

.nav-item {
    /* background-color: rgba(0,0,0,1); */
}

.nav-link {
    background-color: rgba(00, 15, 50, 0.7);
    /* background-color:red; */
    color: #fafafa;
    /* color:red; */
    margin: 5px 0px;
    ;
}

.nav-item.active a {
    /* color:yellow; */
}

.active {
    /* color:yellow; */
}

.nav-link:hover {
    color: #F9BF15;
    color: #FFDD39;
    background-color: rgba(00, 15, 50, 0.9);
}

.li.nav-item {
    /* color:red; */
}

.nav-link.active a {
    /* font-size:0px; */
    background-color: rgba(00, 15, 50, 1);
    font-size: 40px;
    /* color:blue; */
    /* font-color:red; */
}

.nav-fill {
    background-color: blue;
}

.bg-info {
    background-color: green;
}

.informationtable {
    border-radius: 10px;
    background-color: rgba(0, 34, 67, 0.9);
    width: 100%;
}

.informationtable td tr table {
    border-radius: 10px;
    /* background-color:rgba(0,34,67,0.9); */
    color: #fafafa;
    width: 100%;
}

.table {
    color: #fafafa;
    font-size: 12px;
    width: 100%;
}

.table td {
    height: 40px;
    /* margin:0px; */
    /* padding:10px; */
}

.table tr:hover {
    color: #F9BF15;
}

.table tbody {
    height: 100px;
    overflow-y: auto;
}

.table thead th {
    /* background-color: red; */
    background-color: rgba(0, 30, 60, 0);
    border-style: none;
    color: #fafafa;
}

.onetab span {
    background-color: red;
}

#warmanagement___BV_tab_button__.nav-link {
    background-color: rgba(255, 0, 0, 1);
    color: #fafafa;
}

#warmanagement___BV_tab_button__.nav-link:hover {
    background-color: #990008;
    color: #FFDD39;
}

#warmanagement___BV_tab_button__.active {
    background-color: #007BFF;
    background-color: #FFDD39;
    color: red;
}

#warmanagement___BV_tab_button__.active:hover {
    background-color: #007BFF;
    background-color: #FFDD39;
    color: red;
}


/* .page-item a { */


/* background-color:red; */


/* } */

.page-item.disabled .page-link {
    /* background-color:blue; */
}

.page-item.active .page-link {
    /* background-color:blue; */
}

.page-item .page-link {
    /* background-color:rgba(0,30,60,1); */
    background-color: rgba(0, 34, 67, 0.7);
    margin: 10px 0px;
    ;
}

.page-item.disabled .page-link {
    background-color: rgba(0, 0, 0, 0.5);
}

.page-item.active .page-link {
    background-color: #007BFF;
    color: #fafafa;
}

.page-link:hover {
    color: #F9BF15;
}

.pagination {
    border-style: none;
    border-radius: 100px;
}

.page-link {
    border: none;
}

.disabled {
  background-color: grey;
  color:black;
}

.disabled:hover {
  background-color: grey;
  color:black;
}

</style>

<template lang="html">

<div>
    <div v-bind:class="worldstate" style="color:#fafafa;text-align:center;width:200px; border-radius:5px;margin:5px 0px 10px 0px;padding:5px;">WarPool: {{warpoolvalue}} </div>
    <b-card bg-variant="light" style="text-align:left;">
        <b-button-group style="text-align:left;">
            <b-button  :disabled="!peaceActive" @click="SetPeace" v-bind:class="[{bold:peace},{opaque:!peace}]" variant="success">Peace</b-button>
            <b-button :disabled="!allianceActive" @click="SetAlliance" v-bind:class="[{bold:alliance},{opaque:!alliance}]" variant="warning">Preparation(Alliance)</b-button>
            <b-button :disabled="!warActive" @click="SetWar" v-bind:class="[{bold:war},{opaque:!war}]" variant="danger">War</b-button>
        </b-button-group>
        <CountDown admin="true"/>
        <p style="color:#fafafa">This is only for demonstration purpose to be able to switch state</p>

        <b-form-group>
            <div class="timediv">
                <label style="margin:0px 10px; border-style:none; padding:3px;">Peace days: </label>
                <b-form-input label="War days:" id="input2" style="width:200px;" v-model="peacedays" type="number" placeholder="0"></b-form-input>
                <label style="margin:0px 10px;padding:3px;">hours: </label>
                <b-form-input style="width:200px;" v-model="peacehours" type="number" placeholder="0"></b-form-input>
                <b-button v-bind:disabled="!IamGameOwner" variant="success" @click="updatePeaceLimit"> Update </b-button>
                <span style="padding:5px"> Current value: {{peacelimit}} </span>



                <label style="margin:0px 10px; border-style:none; padding:3px;">Alliance days: </label>
                <b-form-input label="War days:" id="input2" style="width:200px;" v-model="alliancedays" type="number" placeholder="0"></b-form-input>
                <label style="margin:0px 10px;padding:3px;">hours: </label>
                <b-form-input style="width:200px;" v-model="alliancehours" type="number" placeholder="0"></b-form-input>
                <b-button  v-bind:disabled="!IamGameOwner" variant="warning" @click="updateAllianceLimit"> Update </b-button>
                <span style="padding:5px"> Current value: {{alliancelimit}} </span>


                <label style="margin:0px 10px; border-style:none; padding:3px;">War days: </label>
                <b-form-input label="War days:" id="input2" style="width:200px;" v-model="wardays" type="number" placeholder="0"></b-form-input>
                <label style="margin:0px 10px;padding:3px;">hours: </label>
                <b-form-input style="width:200px;" v-model="warhours" type="number" placeholder="0"></b-form-input>
                <b-button  v-bind:disabled="!IamGameOwner" variant="danger" @click="updateWarLimit"> Update </b-button>
                <span style="padding:5px"> Current value: {{warlimit}} </span>


                <label style="margin:0px 10px;padding:3px;">Warpool limit [ETH]: </label>
                <b-form-input style="width:200px;" v-model="warpoollimit" type="number" placeholder="0"></b-form-input>
                <div/>
                <div/>
                <b-button  v-bind:disabled="!IamGameOwner" variant="primary" @click="updateWarPoolLimit"> Update </b-button>
                <span style="padding:5px"> Current value: {{swarpoollimit}} </span>

                <label style="margin:0px 10px;padding:3px;">Alliance 1: </label>
                <b-form-input style="width:200px;" v-model="alliance1Name" type="text" placeholder="Alliance 1 Name"></b-form-input>
                <label style="margin:0px 10px;padding:3px;">Alliance 2: </label>
                <b-form-input style="width:200px;" v-model="alliance2Name" type="text" placeholder="Alliance 2 Name"></b-form-input>
                <b-button  v-bind:disabled="!IamGameOwner" variant="primary" @click="updateAlliance"> Update </b-button>
                <span style="padding:5px">{{allianceNames}} </span>
            </div>
        </b-form-group>
    </b-card>
</div>

</template>

<script>

import Vue from 'vue'
import CountDown from './CountDown'
import WarPool from './WarPool'


import BootstrapVue from 'bootstrap-vue'

import bFormGroup from 'bootstrap-vue/es/components/form-group/form-group';
Vue.component('b-form-group', bFormGroup);

import bFormRadio from 'bootstrap-vue/es/components/form-radio/form-radio';
Vue.component('b-form-radio', bFormRadio);
import bFormRadioGroup from 'bootstrap-vue/es/components/form-radio/form-radio-group';
Vue.component('b-form-radio-group', bFormRadioGroup);

import bFormSelect from 'bootstrap-vue/es/components/form-select/form-select';
Vue.component('b-form-select', bFormSelect);

import bTable from 'bootstrap-vue/es/components/table/table';
Vue.component('b-table', bTable);
// import vBModal from 'bootstrap-vue/es/directives/modal/modal';
import bFormInput from 'bootstrap-vue/es/components/form-input/form-input';

Vue.component('b-form-input', bFormInput);
import bButton from 'bootstrap-vue/es/components/button/button';
Vue.component('b-button', bButton);
import bModal from 'bootstrap-vue/es/components/modal/modal';
Vue.component('b-modal', bModal);
import vBModal from 'bootstrap-vue/es/directives/modal/modal';
Vue.directive('b-modal', vBModal);
import {
    ButtonGroup
}
from 'bootstrap-vue/es/components';

Vue.use(ButtonGroup);
import {
    Modal
}
from 'bootstrap-vue/es/components';
Vue.use(Modal);
import bCollapse from 'bootstrap-vue/es/components/collapse/collapse';
Vue.component('b-collapse', bCollapse);
import bPagination from 'bootstrap-vue/es/components/pagination/pagination';
Vue.component('b-pagination', bPagination);
import vBToggle from 'bootstrap-vue/es/directives/toggle/toggle';
Vue.directive('b-toggle', vBToggle);
import {
    Tabs
}
from 'bootstrap-vue/es/components';
Vue.use(Tabs);

import bButtonGroup from 'bootstrap-vue/es/components/button-group/button-group';

Vue.component('b-button-group', bButtonGroup);

import bCard from 'bootstrap-vue/es/components/card/card';

Vue.component('b-card', bCard);
export default {
    components: {
        CountDown,
        WarPool,
        // WarManagement
    },
    data() {
        return {
            peace: false,
            alliance: false,
            war: false,
            sortBy: 'age',
            sortDesc: false,
            // selected: null,

            warpoollimit: 0,
            countDown: '',
            timeLimit: 0,
            // arewehere: 7,
            timer: {},
            alliance1Name: '',
            alliance2Name: '',
            timerStartedAt: Date.now(),
            timerCurrentTime: Date.now(),
            seconds: 0,
        }
    },
    watch: {
        currentPage: function(val) {
            // console.log("CurrentPage:" + val);

        }
    },
    computed: {
        speacedays:function () {
        return this.$store.state.peacedays;
        },
        speacehours:function () {
        return this.$store.state.peacehours;
        },
        salliancedays:function () {
        return this.$store.state.alliancedays;
        },
        salliancehours:function () {
        return this.$store.state.alliancehours;
        },
        swardays:function () {
        return this.$store.state.wardays;
        },
        swarhours:function () {
        return this.$store.state.warhours;
        },
        swarpoollimit:function () {
        return this.$store.state.warpoollimit;
        },
        IamGameOwner: function ()
        {

                    console.log('STATISTICS')
                    console.log(this.$route)
                    console.log('isAuthorized')

                    var web3a = web3.toChecksumAddress(this.$store.state.web3account);
                    console.log(web3a)
                    if(this.$route.path == '/statistics') return false;
                    if (web3a == web3.toChecksumAddress('0x1a5fe261e8d9e8efc5064eeccc09b531e6e24bd3') || web3a == web3.toChecksumAddress(this.$store.state.owner)){
                      return true;
                    }
                    else {
                      return false
                    };
      },
        // countDown: function () {
        //   return  "D:"+ this.timer.getTimeValues().days  +      " H:" + this.timer.getTimeValues().hours + " M:" +this.timer.getTimeValues().minutes + " S:"+parseInt(this.timer.getTimeValues().seconds);
        //
        // },
        peacelimit: function() {
            return this.$store.state.peacedays + " days " + this.$store.state.peacehours + " hours"
        },
        alliancelimit: function() {
            return this.$store.state.alliancedays + " days " + this.$store.state.alliancehours + " hours"
        },
        warlimit: function() {
            return this.$store.state.wardays + " days " + this.$store.state.warhours + " hours"
        },

        warpoolvalue: function() {
            return parseFloat(this.$store.state.warpool).toFixed(6) + " ETH";
        },
        worldstate: function() {
            return this.$store.state.worldstate;
        },
        warActive: function() {
          return true;
            return (this.worldstate == 'alliance')
        },
        peaceActive:function () {
          return true;

          return (this.worldstate == 'war')

        },
        allianceActive:function (){
          return true;

          return (this.worldstate == 'peace')

        },
        allianceNames: function() {
            return "Alliance 1:" + this.$store.state.alliance1Name + " Alliance 2:" + this.$store.state.alliance2Name;
        }
    },
    created: function() {

        var worldstate = this.$store.state.worldstate;
        if (worldstate == 'war') this.war = true;
        if (worldstate == 'peace') this.peace = true;
        if (worldstate == 'alliance') this.alliance = true;
        this.peacehours = this.$store.state.peacehours;
        this.peacedays = this.$store.state.peacedays;
        this.alliancehours = this.$store.state.alliancehours;
        this.alliancedays = this.$store.state.alliancedays;
        this.warhours = this.$store.state.warhours;
        this.wardays = this.$store.state.wardays;
        this.timeLimit = this.$store.state.timeLimit;
        this.warpool = this.$store.state.warpoollimit;
        this.alliance1Name = this.$store.state.alliance1Name;
        this.alliance2Name = this.$store.state.alliance2Name;
        // this.startCountDown();
        // this.updateTime();
        this.doTheTime();

    },
    watch: {
      speacedays: function(val)
      {
        this.peacedays=val;
      },

      speacehours: function(val)
      {
        this.peacehours=val;
      },

      salliancedays: function(val)
      {
        this.alliancedays=val;
      },

      salliancehours: function(val)
      {
        this.alliancehours=val;
      },

      swardays: function(val)
      {
        this.wardays=val;
      },

      swarhours: function(val)
      {
        this.warhours=val;
      },
      swarpoollimit: function(val)
      {
        this.warpoollimit=val;
      },

    },
    methods: {

        doTheTime: function() {
            var that = this;
            setInterval(function() {
                that.timerCurrentTime = Date.now();
                var seconds = that.$store.state.timeLimit - Math.round(that.timerCurrentTime / 1000);
                // console.log(that.countDown);

                var days = Math.floor(seconds / (3600 * 24));
                seconds -= days * 3600 * 24;
                var hrs = Math.floor(seconds / 3600);
                seconds -= hrs * 3600;
                var mnts = Math.floor(seconds / 60);
                seconds -= mnts * 60;

                that.countDown = days + ' ' + hrs + ' ' + mnts + ' ' + ' ' + seconds;
            }, 1000);
        },
        updatePeaceLimit() {
            this.$store.web3contract.SetStateTime(0,this.peacedays,this.peacehours,function (err,res){
            })
            this.timeLimit = this.$store.state.timeLimit;

        },
        updateAllianceLimit() {
            this.$store.web3contract.SetStateTime(1,this.alliancedays,this.alliancehours,function (err,res){
            })

        },
        updateWarLimit() {
            this.$store.web3contract.SetStateTime(2,this.wardays,this.warhours,function (err,res){
            })

        },
        updateWarPoolLimit() {
            var limit = web3.toWei(this.warpoollimit,"ether");
            this.$store.web3contract.UpdateWarpoolLimit(limit,function(err,res) {

            })

        },
        updateAlliance() {
            this.$store.state.alliance1Name = this.alliance1Name;
            this.$store.state.alliance2Name = this.alliance2Name;

        },
        showModal() {
            this.$refs.myModalRef.show()
        },
        SetWar: function() {
            // this.war = true;
            // this.alliance = false;
            // this.peace = false;
            // // this.$store.commit('War');
            // this.timeLimit = this.$store.state.timeLimit;
            this.$store.web3contract.ownedSetWorldState(2,function(err,res){})
        },
        SetPeace: function() {
            this.$store.web3contract.ownedSetWorldState(0,function(err,res){})
            //
            // this.war = false;
            // this.alliance = false;
            // this.peace = true;
            // // this.$store.commit('Peace');
            // this.timeLimit = this.$store.state.timeLimit;

        },
        SetAlliance: function() {
            // this.war = false;
            // this.alliance = true;
            // this.peace = false;
            // this.$store.commit('Alliance');
            // this.timeLimit = this.$store.state.timeLimit;
            this.$store.web3contract.ownedSetWorldState(1,function(err,res){
              if (err)
              {
                console.log(err)

              }
              else {
                console.log(res)
              }

            })

        },
        hideModal() {
            this.$refs.myModalRef.hide()
        }
    }
}

</script>
