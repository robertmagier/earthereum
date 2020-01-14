<style >

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

</style>

<template>
  <div>
<!-- <div v-if="!isAuthorized" style="color:white;font-size:32px;text-transform:uppercase;font-weight:800;">
  <br><br><br>
  <div style="text-align:center;background-color:rgba(0,0,0,0.3);vertical-align:middle;padding:10px;"> You don't have permission to access this page</div>

</div> -->
<div style="margin:50px;min-height:325px;">
    <b-tabs pills vertical class="btabs">
        <!-- <b-button @click="showModal" style="margin:10px 00px; background-color:red">
      Start the War
    </b-button> -->
        <b-tab v-if="isAuthorized" id="warmanagement" title="War Management">
            <WarManagement> </WarManagement>
        </b-tab>
        <b-tab v-if="isAuthorized" id="countiresManagement" title="Countries">
            <CountriesManagement> </CountriesManagement>
        </b-tab>

        <b-tab id="warresults" title="War Results" style="">
          <WarResults></WarResults>
        </b-tab>

        <b-tab id="attacks" title="Attacks" style="">
          <AttackTransactions></AttackTransactions>

        </b-tab>
        <b-tab title="Transactions  (Buy)">
          <BuyTransactions></BuyTransactions>
        </b-tab>
        <!-- <b-pagination :total-rows="totalRows" per-page=10 v-model="currentPage" class="my-0" /> -->
        <b-tab v-if="isAuthorized" title="Owners">
          <Owners></Owners>
        </b-tab>
        <b-tab id="ranking" title="Ranking">
            <RankingTable></RankingTable>
        </b-tab>
    </b-tabs>

    <b-modal ref="myModalRef" centered hide-footer title="Are you sure ?" style="color:black">
        <div class="d-block text-center">
            <p class="blacky">War will finish in 2 days from now and you will not be able to stop it. Press ESC to cancel. </p>
        </div>
        <b-button class="mt-3" variant="outline-danger" block @click="hideModal">Start the War</b-button>
    </b-modal>
</div>
</div>
</template>

<script>

var styleLoader = require("style-loader")

import Vue from 'vue'
import CountDown from './CountDown'
import WarPool from './WarPool'
import RankingTable from './RankingTable'
import Owners from './Owners'
import WarManagement from './WarManagement'
import BuyTransactions from './BuyTransactions'
import AttackTransactions from './AttackTransactions'
import CountriesManagement from './CountriesManagement'
import WarResults from './WarResults'

// ************************************* BOOTSTRAP IMPORT ******************8
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

const fields = [{
    key: 'value_per',
    sortable: true
}, {
    key: 'from',
    sortable: true
}, {
    key: 'to',
    sortable: true
}, {
    key: 'value_eth',
    sortable: true
}, {
    key: 'time_stamp',
    sortable: true
}]
const items = [{
        from: 'CA',
        to: 'MX',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/20 19:00'
    }, {
        from: 'CA',
        to: 'MX',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/20 19:00'
    }, {
        from: 'CA',
        to: 'MX',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/20 19:00'
    }, {
        from: 'CA',
        to: 'MX',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/20 19:00'
    }, {
        from: 'CA',
        to: 'MX',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/20 19:00'
    }, {
        from: 'CA',
        to: 'MX',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/20 19:00'
    }, {
        from: 'CA',
        to: 'MX',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/20 19:00'
    }, {
        from: 'CA',
        to: 'MX',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/20 19:00'
    }, {
        from: 'CA',
        to: 'MX',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/20 19:00'
    }, {
        from: 'CA',
        to: 'MX',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/20 19:00'
    }, {
        from: 'CA',
        to: 'MX',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/20 19:00'
    }, {
        from: 'CA',
        to: 'MX',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/20 19:00'
    }, {
        from: 'CA',
        to: 'MX',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/20 19:00'
    }, {
        from: 'PL',
        to: 'ZA',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/17 17:00'
    }, {
        from: 'SE',
        to: 'RU',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/16 12:00'
    }, {
        from: 'LI',
        to: 'CA',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/05 13:00'
    }, {
        from: 'TA',
        to: 'WP',
        value_per: '5%',
        value_eth: '1.1 ETH',
        time_stamp: '2018/02/02 05:00'
    },

]

const transactions = [{
    owner: '0xE404C32447d48a20607e128970F80fCBFF81950E',
    country: 'Mexico',
    value: '1.15 ETH',
    fee: '0.03 ETH',
    warpool_fee: '0.01 ETH',
    timestamp: '2018/02/17 17:00'
}, {
    owner: '0xE404C32447d48a20607e128970F80fCBFF81950E',
    country: 'United States',
    value: '1.15 ETH',
    fee: '0.03 ETH',
    warpool_fee: '0.01 ETH',
    timestamp: '2018/02/17 17:00'
}, {
    owner: '0xE404C32447d48a20607e128970F80fCBFF81950E',
    country: 'Russian Federation',
    value: '1.15 ETH',
    fee: '0.03 ETH',
    warpool_fee: '0.01 ETH',
    timestamp: '2018/02/17 17:00'
}, {
    owner: '0xE404C32447d48a20607e128970F80fCBFF81950E',
    country: 'Brasil',
    value: '1.15 ETH',
    fee: '0.03 ETH',
    warpool_fee: '0.01 ETH',
    timestamp: '2018/02/17 17:00'
}]

const owners = [{
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: '1jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: '2jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: '3jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: '4jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: '5jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: '6jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: '7jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: 'j8an.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: '9jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: '10jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: '11jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: '12jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: 'jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: 'jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: 'jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: 'jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: 'afdafjan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: 'jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: 'jan.kowfsdfdsalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: 'jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: 'jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: 'jan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: 'janfdsfsdf.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }, {
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        e_mail: 'ostatnijan.kowalski@gmail.com',
        countries_owned: 'US MX RU'
    }

]

export default {
    components: {
        RankingTable,
        CountDown,
        WarPool,
        WarManagement,
        CountriesManagement,
        Owners,
        BuyTransactions,
        AttackTransactions,
        WarResults
    },
    data() {
        return {
            peace: false,
            alliance: false,
            war: false,
            sortBy: 'age',
            sortDesc: false,
            items: items,
            fields: fields,
            transactions: transactions,
            owners: owners,
            currentPage: 1,
            currentPageOwners: 1,
            perPageAttacks: 10,
            perPage: 10,
            perPageOwners: 5,
            totalAttacksRows: 30,
            totalOwnersRows: 100,
            selected: null,
            peacehours: 0,
            peacedays: 0,
            alliancehours: 0,
            alliancedays: 0,
            warhours: 0,
            wardays: 0,
            warpool: 0,
            currentPageTransactions: 1,
            currentPageTransaction: 1,
            perPageTransactions: 10,
            countDown: '',
            timeLimit: 0,
            arewehere: 7,
            timer: {},
            alliance1Name: '',
            alliance2Name: '',
            timerStartedAt: Date.now(),
            timerCurrentTime: Date.now(),
            seconds: 0,
            options: [{
                value: null,
                text: 'Please select an option'
            }, {
                value: 'a',
                text: 'This is First option'
            }, {
                value: 'b',
                text: 'Selected Option'
            }, {
                value: {
                    'C': '3PO'
                },
                text: 'This is an option with object value'
            }, {
                value: 'd',
                text: 'This one is disabled',
                disabled: true
            }]
        }
    },
    watch: {
        currentPage: function(val) {
            // console.log("CurrentPage:" + val);

        }
    },
    computed: {
        // countDown: function () {
        //   return  "D:"+ this.timer.getTimeValues().days  +      " H:" + this.timer.getTimeValues().hours + " M:" +this.timer.getTimeValues().minutes + " S:"+parseInt(this.timer.getTimeValues().seconds);
        //
        // },
        isAuthorized: function ()
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
        peacelimit: function() {
            return this.$store.state.peacedays + " days " + this.$store.state.peacehours + " hours"
        },
        alliancelimit: function() {
            return this.$store.state.alliancedays + " days " + this.$store.state.alliancehours + " hours"
        },
        warlimit: function() {
            return this.$store.state.wardays + " days " + this.$store.state.warhours + " hours"
        },
        warpoollimit: function() {
            return this.$store.state.warpoollimit + " ETH";
        },
        warpoolvalue: function() {
            return parseFloat(this.$store.state.warpool).toFixed(3) + " ETH";
        },
        worldstate: function() {
            return this.$store.state.worldstate;
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
    watch: {},
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
            this.$store.state.peacedays = this.peacedays;
            this.$store.state.peacehours = this.peacehours;
            this.timeLimit = this.$store.state.timeLimit;

        },
        updateAllianceLimit() {
            this.$store.state.alliancedays = this.alliancedays;
            this.$store.state.alliancehours = this.alliancehours;
            this.timeLimit = this.$store.state.timeLimit;

        },
        updateWarLimit() {
            this.$store.state.wardays = this.wardays;
            this.$store.state.warhours = this.warhours;
            this.timeLimit = this.$store.state.timeLimit;

        },
        updateWarPoolLimit() {
            this.$store.state.warpoollimit = this.warpool;
        },
        updateAlliance() {
            this.$store.state.alliance1Name = this.alliance1Name;
            this.$store.state.alliance2Name = this.alliance2Name;

        },
        showModal() {
            this.$refs.myModalRef.show()
        },
        SetWar: function() {
            this.war = true;
            this.alliance = false;
            this.peace = false;
            this.$store.commit('War');
            this.timeLimit = this.$store.state.timeLimit;
        },
        SetPeace: function() {
            this.war = false;
            this.alliance = false;
            this.peace = true;
            this.$store.commit('Peace');
            this.timeLimit = this.$store.state.timeLimit;
        },
        SetAlliance: function() {
            this.war = false;
            this.alliance = true;
            this.peace = false;
            this.$store.commit('Alliance');
            this.timeLimit = this.$store.state.timeLimit;
        },
        hideModal() {
            this.$refs.myModalRef.hide()
        }
    }
}

</script>
