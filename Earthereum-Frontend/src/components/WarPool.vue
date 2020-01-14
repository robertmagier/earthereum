<template lang="html">
  <div id="WarPool">

    <div class="card-title"><span>War pool</span></div>
    <div class="card-value">
      <b>{{warpool}} </b>
    </div>


    </div>
</template>

<script>
export default {
  name:'Warpool',
  methods: {
  },
  computed: {
    warpool: function() {
      var warpool = this.$store.state.warpool
      warpool = parseFloat(warpool).toFixed(6);
      return warpool;
    }
  }
}
</script>

<style lang="css">
</style>
