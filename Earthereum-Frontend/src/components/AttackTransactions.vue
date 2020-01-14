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
  <b-pagination size="sm" :total-rows="totalrows" :per-page="10" v-model="currentPageRanking" class="my-0" />

    <b-table :per-page="perPageRanking" :fields="rankingFields" striped hover :currentPage="currentPageRanking" class="informationtable" :items="attackTransactions" style="width:100%;">

      <template slot="timestamp" slot-scope="data">
        {{textTime(data.value)}}
      </template>

      <template slot="attackType" slot-scope="data">
        {{data.value}} %
      </template>

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
    key: 'attacker',
    label: 'Attacker',
    sortable: true
}, {
    key: 'cname',
    label: 'Country Name',
    sortable: true
}, {
    key: 'attackType',
    label:'Attack Type [%]',
    sortable: true
}, {
    key: 'attackValue',
    label: 'Attack Value [ETH]',
    sortable: true
}, {
    key: 'defendedString',
    label: 'Defended [true/false]',
    sortable: true
}]
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
            currentPageRanking: 1,
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
          return this.$store.state.countryAttackEventsData.length
        },
        attackTransactions: function () {
          // console.log("ATTACK TRANSACTIONS!!!")
          // console.log(this.$store.state.countryAttackEventsData )
          for (var item in this.$store.state.countryAttackEventsData )
          {
            this.$store.state.countryAttackEventsData[item].attackType = parseInt(this.$store.state.countryAttackEventsData[item].attackType);

            this.$store.state.countryAttackEventsData[item].defendedString = this.$store.state.countryAttackEventsData[item].defended ? "Yes" : "No"
            var code = this.$store.state.countryAttackEventsData[item].ccode;
            code = code.slice(0,2)
            // console.log("MAGIER: "+code)

            this.$store.state.countryAttackEventsData[item].cname = this.$store.getters.getCountry(code).cname

            // this.$store.state.countryAttackEventsData[item].cname = this.$store.getters.getCountry(this.$store.state.countryAttackEventsData[item].ccode).cname
            // console.log(item)
          }
          return this.$store.state.countryAttackEventsData;




        },

    }

}

</script>
