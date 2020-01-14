<style lang="css">

.dragons {
  color: #fafafa;
  background-color:rgba(255,0,0,0.8);
}

.disabled
{
  background-color:rgba(0,0,0,0.3);
  color:#555;
}
.bears {
  color:#fafafa;
  background-color:rgba(0,0,255,0.7);
}

.board {
  display:grid;
  grid-template-columns: 1fr 1fr 1fr ;
  padding:0px;
  /* margin:0px 5px 0px 5px; */
  font-size:10px;
  text-align: center;

}
.draw {
  background-color:rgba(255,255,255,0.5);
}
.noalliance {
  background-color:rgba(255,255,255,0.5);

}
/* .c2 {
  grid-column: 2/4;
  font-weight: 500;
  border-radius:10px;
  width:50%;
  align-items: center;
} */

.c1 {
  border-radius:10px;
  margin:5px;
  height:30px;
  text-align: center;
  padding:10px;
  font-weight:800;

}

</style>

<template lang="html">

<div class="card-warning card-content">
    <!-- <div class="card-title">
        <span>Board</span>
    </div> -->
    <div class="board">
            <div v-bind:class="[{bears:bears,dragons:dragons,noalliance:noalliance,c1:true,disabled:peace}]" >Your alliance: {{getAllianceName()|uppercase}}</div>
            <!-- <div v-bind:class="[{peace:peace,alliance:alliance,war:war,cc:true},cc]" >World State:{{getWorldState()|uppercase}}</div> -->
            <div v-bind:class="{dragons:!peace,disabled:peace,c1:true}">Dragons value: <b>{{getAllianceValue(1)}}</b> ETH </div>
            <div v-bind:class="{dragons:war,c1:true,disabled:!war}">Dragons attacks value: <b> {{getAllianceScore(1)}}</b> ETH</div>
            <div v-bind:class="[{disabled:!war,c1:true},winner]">{{winnerName}}</div>
            <div  v-bind:class="{bears:!peace,disabled:peace,c1:true}">Bears value: <b> {{getAllianceValue(2)}}</b> ETH</div>
            <div v-bind:class="{bears:war,c1:true,disabled:!war}">Bears attacks value: <b> {{getAllianceScore(2)}}</b> ETH</div>
    </div>
</div>

</template>

<script>

export default {
    name: 'Warning',
    data() {
        return {
            test: '1',
            test2: '2'
        }
    },
    methods: {
      getAllianceName:function() {
        return this.$store.getters.getAllianceName();
      },
      getWorldState: function () {
        return this.$store.state.worldstate;
      },
      getAllianceValue: function (_num)
      {
        if(_num == 1) {
          return this.$store.state.alliance1Value;
        }
        if(_num == 2) {
          return this.$store.state.alliance2Value;
        }

      },
      getAllianceScore: function (_num)
      {
        if(_num == 1) {
          return this.$store.state.alliance1Score;
        }
        if(_num == 2) {
          return this.$store.state.alliance2Score;
        }

      }
    },
    computed: {
      winner: function () {
        if ((this.getAllianceScore(1) > this.getAllianceScore(2))&& this.war) {
          return "dragons c1";
        }
        if ((this.getAllianceScore(1) < this.getAllianceScore(2)) && this.war) {
          return "bears c1";
        }
        if ((this.getAllianceScore(1) == this.getAllianceScore(2))&& this.war) {
          return "draw c1";
        }

      },
      winnerName: function () {
        if ((this.getAllianceScore(1) > this.getAllianceScore(2)) &&this.war) {
          return "Winning: Dragons";
        }
        if ((this.getAllianceScore(1) < this.getAllianceScore(2)) && this.war) {
          return "Winning: Bears";
        }
        if (this.getAllianceScore(1) == this.getAllianceScore(2)) {
          return "Draw" + ' #' + this.$store.state.drawNumber;;
        }

      },
      peace: function ()
      {
        return (this.$store.state.worldstate=='peace')
      },
      war: function () {
        return (this.$store.state.worldstate=='war')

      },
      bears: function () {
        return (this.$store.state.alliance == 2) && (!this.peace)
      },
      dragons: function () {
        return (this.$store.state.alliance == 1) && (!this.peace)
      },
      noalliance: function () {
          return (!(((this.$store.state.alliance == 1) || (this.$store.state.alliance == 2)))&& (this.alliance || this.war ));
      },

    }
}

</script>
