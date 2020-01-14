<template lang="html">
  <div id="News" class="card-content card-news">

    <div class="card-title"><span>News</span></div>
    <div class="card-value" style="height:200px;overflow-y:scroll;font-size:10px;">
      <div v-for="information in news">
      <div class="news-date" style="font-size:12px">
      <b>{{information.timestring}} </b>
      </div>
      <!-- Buy transaction -->
      <div v-if="information.type=='buy'"class="news-text" style="font-size:12px">
         {{information.ccode}} bought for {{information.cprice}} ETH
      </div>
      <div v-if="information.type=='draw'"class="news-text" style="font-size:12px">
        There was a draw. War has been extended by 1 hour. 
      </div>
      <div v-if="information.type=='alliance'"class="news-text" style="font-size:12px">
      {{information.value| truncate(6)}} changed alliance to <b>{{GetAllianceName(information.secondaryvalue)}}</b>
      </div>
      <!-- Buy transaction -->
      <div v-if="information.type=='state'" class="news-text" style="background-color:rgba(0,0,0,0.2);font-size:12px">
        <b>Start of </b>
        <span style="color:green" v-if="information.value=='0'">Peace</span>
        <span  style="color:yellow" v-if="information.value=='1'">Alliance</span>
        <span style="color:red" v-if="information.value=='2'">WAR</span>

      </div>
      <!-- Attack -->
      <div v-if="information.type=='attack'" class="news-text" style="font-size:12px">
         {{information.ccode}} attacked for {{information.cprice}}%.
         <span v-if="information.defended"> Defended </span>
      </div>

    </div>
    </div>

  </div>
</template>

<script>

export default {
  methods: {
    getTimeDate: function(tst) {
      var time = new Date(tst);
      return time.toLocaleString();

    },
    GetAllianceName: function(_num)
    {
      return this.$store.getters.getAllianceName(_num);
    }
  },
  computed: {
    news: function() {
      return this.$store.state.newsEventsData;
    }
  }
}
</script>

<style lang="css">
</style>
