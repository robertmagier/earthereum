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
  <b-pagination size="sm" :total-rows="totalrows" :per-page="perPageRanking" v-model="currentPageRanking" class="my-0" />

    <!-- <h4 style="color:#fafafa;background-color:rgba(255,255,255,0.1);margin:5px 0px 0px 0px;border-radius:5px;padding:5px;font-weight:600">BUY TRANSACTIONS</h4> -->
    <b-table :sort-by="sortBy" :sort-desc="sortDesc" :per-page="perPageRanking" :fields="rankingFields" striped hover :currentPage="currentPageRanking" class="informationtable" :items="buyTransactions" striped small style="width:100%;">

      <template slot="timestamp" slot-scope="data">
        {{textTime(data.value)}}
      </template>

    </b-table>
</center>

</template>

<script>


const fields = [{
    key: 'timestamp',
    label: 'Time',
    sortable: true
}, {
    key: 'cowner',
    label: 'Buyer',
    sortable: true
},

{
    key: 'cname',
    label: 'Country Name',
    sortable: true
}, {
    key: 'cprice',
    label:'Price [ETH]',
    sortable: true
}, {
    key: 'afee',
    label: 'Admin Fee [ETH]',
    sortable: true
}, {
    key: 'warpool',
    label: 'War Pool Fee [ETH]',
    sortable: true
}, {
    key: 'cfee',
    label: 'Continent Fee [ETH]',
    sortable: true

}, {
    key: 'wfee',
    label: 'World Fee [ETH]',
    sortable: true
} ]
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
            sortDesc:true,
            sortBy:'timestamp',
            rankingFields: fields,
            currentPageRanking: 1,
            perPageRanking: 20,
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

          return this.$store.state.buyEventsData.length
        },
        buyTransactions: function () {
          console.log(this.$store.state.buyEventsData)
          for (var item in this.$store.state.buyEventsData )
          {
            var ts = this.$store.state.buyEventsData[item].timestamp
            this.$store.state.buyEventsData[item].timestring = new Date(ts * 1000).toLocaleString();
            this.$store.state.buyEventsData[item].cname = this.$store.getters.getCountry(this.$store.state.buyEventsData[item].ccode).cname
          }
          return this.$store.state.buyEventsData;


        },

    }

}

</script>
