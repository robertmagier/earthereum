<template>
  <div id="AmMap" class="AmMap" style="height:200px">
  Anybodydfdf <h1>teste test tetest ests</h1>
  </div>
</template>

<script>
import vueResource from 'vue-resource'
  import 'amcharts3'
  import 'amcharts3/amcharts/plugins/responsive/responsive.js'
  import 'amcharts3/amcharts/serial.js'
  import 'amcharts3/amcharts/themes/light'
  import 'ammap3'
  import 'ammap3/ammap/maps/js/worldLow'
  import 'ammap3/ammap/maps/js/worldHigh'

  export default {
    name: 'AmMap',
    components:{ AmMap },
    data () {
      return {
        newUser: ''
      }
    },
    //props: ['mapData'],
    methods: {
      drawMap () {
        /* global AmCharts */
        let map
        // let minBulletSize = 3
        // let maxBulletSize = 70
        // let min = Infinity
        // let max = -Infinity
        // AmCharts.theme = AmCharts.themes.dark
        // get min and max values
        // this.mapData.data.forEach((dataItem) => {
        //   let value = dataItem.value
        //   if (value < min) {
        //     min = value
        //   }
        //   if (value > max) {
        //     max = value
        //   }
        // })
        // build map
        map = new AmCharts.AmMap()
        map.projection = 'miller'
        map.addListener('selectedObjectChanged',function(mapka){

          // console.log(map.selectedObject.id);
//          alert('test')

        })
        map.addTitle('Countries of the world', 14, 1, 1, false)
        map.addTitle('source: Gapminder', 14, 1, 1, 1, false)
        map.areasSettings = {
          unlistedAreasColor: '#fff',
          // unlistedAreasAlpha: 1,
          outlineColor: '#fff',
          outlineThickness: 1,
          selectedColor: 'blue',
          autoZoom: false,
          selectable: true,
          //color:'red',
          //balloonText: '[[description]]',
          rollOverColor:"black"

        }
        map.smallMap = {};
        map.imagesSettings = {
          balloonText: '<span style="font-size:14px"><b>[[title]]</b>: [[value]]</span>',
          alpha: 1
        }
        var dataProvider = {
          // mapVar: AmCharts.maps.worldLow,
          map:'worldLow',
          getAreasFromMap: true,
          images: [],
          areas: [
            {
       id: "US",
       showAsSelected: false,
       accessibleLabel: 'Hej Misiu',
       alpha:1,
       baloonText: 'ydghdgfd',
       // color:'grey'


     }
          ]
        }
        // create circle for each country
        // it's better to use circle square to show difference between values, not a radius
        // var maxSquare = maxBulletSize * maxBulletSize * 2 * Math.PI
        // var minSquare = minBulletSize * minBulletSize * 2 * Math.PI
        // create circle for each country
        // this.mapData.data.forEach((dataItem) => {
        //   var value = dataItem.value
        //   // calculate size of a bubble
        //   var square = (value - min) / (max - min) * (maxSquare - minSquare) + minSquare
        //   if (square < minSquare) {
        //     square = minSquare
        //   }
        //   var size = Math.sqrt(square / (Math.PI * 2))
        //   var id = dataItem.code
        //   dataProvider.images.push({
        //     type: 'circle',
        //     width: size,
        //     height: size,
        //     color: dataItem.color,
        //     longitude: this.mapData.latlong[id].longitude,
        //     latitude: this.mapData.latlong[id].latitude,
        //     title: dataItem.name,
        //     value: value
        //   })
        // })
        map.dataProvider = dataProvider
        //map.write(this.$el)
      }
    },

    created: function () {
      //this.drawMap()
      // console.log('Ammappppspdos')
      // console.log(this)
    }
  }
</script>

<style>

  .ammap {
    height: 500px;
  }
</style>
