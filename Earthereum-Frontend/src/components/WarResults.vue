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

    <b-table small :per-page="10" :fields="rankingFields" striped hover :currentPage="currentPage" class="informationtable" :items="warResults" style="width:100%;">
      <template slot="timestamp" slot-scope="data">
        {{textTime(data.value)}}
      </template>
        <template slot="show_details" slot-scope="row">
            <!-- we use @click.stop here to prevent emitting of a 'row-clicked' event  -->
            <b-button v-bind:disabled="!row.item.sharesEnabled" size="sm" @click.stop="row.toggleDetails" style="font-size:12px;padding:2px 10px">
                {{ row.detailsShowing ? 'Hide' : 'Show'}} Details
            </b-button>
        </template>

        <template slot="row-details" slot-scope="row">
          <b-table outlinedfooter-variant="light" small class="informationtable" style="transition:all 1s;border-radius:10px;color:#00ff00;background-color:rgba(255,255,255,0.1);" :fields="usfields" stripped hover :items="row.item.usersshares">



          </b-table>

        </template>

        <!-- <template slot="attackType" slot-scope="data">
            {{data.value}} %
        </template> -->

    </b-table>

</center>

</template>

<script>

// countryAttackedData.attacker = res.args._attacker;
// countryAttackedData.ccode = res.args._CR;
// countryAttackedData.attackType = res.args._attackType;
// countryAttackedData.attackValue = res.args._attackvalue;
// countryAttackedData.defended = res.args.defended;

const fields = [{
    key: 'timestamp',
    label: 'Time',
    sortable: true
}, {
    key: 'winnerName',
    label: 'Winner',
    sortable: true
}, {
    key: 'a1valueETH',
    label: 'Alliance #1 attack strength [ETH]',
    sortable: true
}, {
    key: 'a2valueETH',
    label: 'Alliance #2 attack strength [ETH]',
    sortable: true
}, {
    key: 'show_details'
}]

const usfields = [
//   {
//     key: 'timestring',
//     label: 'Date',
//     sortable: true
// },
  {
    key: 'user',
    label: 'User address',
    sortable: true
},
  {
    key: 'share',
    label: 'Share [%]',
    sortable: true
},
  {
    key: 'valueETH',
    label: 'Value[ETH]',
    sortable: true
},

]
import Vue from 'vue'
import BootstrapVue from 'bootstrap-vue'
import bTable from 'bootstrap-vue/es/components/table/table';
import bCard from 'bootstrap-vue/es/components/card/card';
Vue.component('b-card', bCard);
Vue.component('b-table', bTable);
export default {
    name: 'AttackTransactions',
    data() {
        return {
            rankingFields: fields,
            usfields: usfields,
            currentPage: 1,
            perPageRanking: 10,
        }
    },
    methods: {
      textTime: function(num)
      {
        return new Date(num * 1000).toLocaleString();
      }
    },
    computed: {
       totalrows: function () {
         return this.warResults.length
       },
        warResults: function() {
            console.log("War Results")

            var results = [];

            for (var item in this.$store.state.warResultsEventsData) {
                var el = this.$store.state.warResultsEventsData[item];
                if (this.$store.state.warResultsEventsData[item].usersshares.length >0 )
                {
                  el.sharesEnabled = true

                }
                else {
                  el.sharesEnabled = false

                }
                el.timestring = new Date(el.timestamp * 1000).toLocaleString();
                el.a1valueETH = web3.fromWei(el.a1value, "ether") + " ETH"
                el.a2valueETH = web3.fromWei(el.a2value, "ether") + " ETH"
                el.winnerName = this.$store.getters.getAllianceName(el.winner);
                    // el.timestring = el.timestamp;
                results.push(el);
            }
            console.log(results);
            return results;


        },
        user: function () {
          var user = [];
          user.push({share:1})
          user.push({share:2})
          user.push({share:4})
          user.push({share:3})
          return user;
        }

    }

}

</script>
