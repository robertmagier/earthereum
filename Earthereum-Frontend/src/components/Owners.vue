<style lang="css">

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

.table tr {
    transition: color 0.3s;
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

<template lang="html">

<center>
  <b-pagination size="sm" :total-rows="totalrows" :per-page="10" v-model="currentPage" class="my-0" />
  <b-table :per-page="10" :fields="rankingFields" striped hover :currentPage="currentPage" class="informationtable" :items="ranking" style="width:100%;"></b-table>
</center>

</template>

<script>

const owners = [{
        ranking: '1',
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        countries: 'US MX RU',
        value: '78.12 ETH',
    }, {
        ranking: '2',
        account: 'Jan Kowalski',
        countries: 'ZA BL BO AR',
        value: '14.13 ETH'
    }, {
        ranking: 3,
        account: 'Donald Not Triumphant',
        countries: 'CA',
        value: '19.87 ETH'
    }, {
        ranking: 4,
        account: 'John Doe',
        countries: 'US',
        value: '20.123 ETH'
    }, {
        ranking: 5,
        account: 'Donald The Brave',
        countries: 'BR',
        value: '15.100 ETH'
    }, {
        ranking: 6,
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        countries: 'TH',
        value: '19.100 ETH'
    }, {
        ranking: 7,
        account: 'Donald the Stupid',
        countries: 'AU',
        value: '17.125 ETH'
    }, {
        ranking: 8,
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        countries: 'KR',
        value: '19.76 ETH'
    }, {
        ranking: 9,
        account: 'Donald The Wise',
        countries: 'AF NR GB',
        value: '37.89 ETH'
    }, {
        ranking: 10,
        account: '0xE404C32447d48a20607e128970F80fCBFF81950E',
        countries: 'PL LI SE',
        value: '24.129 ETH'
    },

]
const fields = [{
    key: 'ranking',
    sortable: true
}, {
    key: 'account',
    sortable: true
}, {
    key: 'email',
    sortable: true
}, {
    key: 'countries',
    sortable: true
}, {
    key: 'value',
    sortable: true
}, ]
import Vue from 'vue'
import BootstrapVue from 'bootstrap-vue'
import bTable from 'bootstrap-vue/es/components/table/table';
import bCard from 'bootstrap-vue/es/components/card/card';
Vue.component('b-card', bCard);
Vue.component('b-table', bTable);
export default {
    name: 'Owners',
    data() {
        return {
            rankingFields: fields,
            currentPageRanking: 1,
            perPageRanking: 10,
        }
    },
    computed: {
      totalrows: function (){
        return this.ranking.length;
      },
        ranking: function() {
            var tmpRanking = {};
            var rankingA = [];
            for (var item in this.$store.state.countries) {
                // console.log("ranking");
                var tmpOwner = this.$store.state.countries[item].cowner;
                var tmpPrice = this.$store.state.countries[item].cprice;
                var tmpccode = this.$store.state.countries[item].ccode;
                var tmpcname = this.$store.state.countries[item].cname;
                var tmpemail = 'robert.magier@gmail.com';
                if (tmpRanking[tmpOwner] == undefined) {
                    tmpRanking[tmpOwner] = {}
                }
                tmpRanking[tmpOwner].ranking = 1;
                tmpRanking[tmpOwner].account = tmpOwner;
                if (tmpRanking[tmpOwner].countries == undefined) {
                    tmpRanking[tmpOwner].countries = ' &bull; ' + tmpcname;

                } else {
                    tmpRanking[tmpOwner].countries += ' &ensp;&bull;&ensp;' + tmpcname;

                }

                if (tmpRanking[tmpOwner].value == undefined) {
                    tmpRanking[tmpOwner].value = parseFloat(tmpPrice);

                } else {
                    tmpRanking[tmpOwner].value += parseFloat(tmpPrice);

                }

                tmpRanking[tmpOwner].email = tmpemail;

                // console.log(tmpOwner + ' ' + tmpPrice + ' ' + tmpccode + ' ' + tmpcname)
                    // tmpranking[]
            }

            for (item in tmpRanking) {
                tmpRanking[item].value = parseFloat(tmpRanking[item].value).toFixed(6);
                rankingA.push(tmpRanking[item]);
            }
            rankingA.sort(function(a, b) {
                if (a.value > b.value) return -1;
                if (a.value < b.value) return 1;
                if (a.value == b.value) return 0;
            })

            for (item in rankingA) {
                rankingA[item].ranking = parseInt(item) + 1;
            }
            return rankingA;
        }
    }

}

</script>
