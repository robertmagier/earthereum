<template lang="html">
<div>
<p v-for="country in countries">Hey Whats up {{country.cname}} ?</p>

</div>
</template>

<script>
export default {
  name: 'TestStorage',
  data() {
    return {
    }
  },
  computed: {
    countries: function() {
      return this.$store.state.countries;
    },

  },
  created: function() {

  },
  watch: {


  },
  updated: function() {
  }
}
</script>

<style lang="css">
</style>
