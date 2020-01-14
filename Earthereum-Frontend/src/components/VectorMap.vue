<style scoped>

@import '../style2.css';

</style>

<template>

<div id="VectorMap" class="VectorMap" style="height:380px;width:100%">
    {{countries}} {{updateMape}}
</div>

</template>

<script>

// import vueResource from 'vue-resource'
import vueResource from 'vue-resource'
import Vue from 'vue'

import 'amcharts3'
import 'amcharts3/amcharts/plugins/responsive/responsive.js'
import 'amcharts3/amcharts/serial.js'
import 'amcharts3/amcharts/themes/light'
import 'ammap3'
import 'ammap3/ammap/maps/js/worldLow'
import 'ammap3/ammap/maps/js/worldHigh'
import CountryCard from './CountryCard'


export default {
    name: 'VectorMap',
    components: {
        CountryCard
    },
    data() {
        return {
            newUser: '',
            map: {},

        }
    },
    //props: ['mapData'],
    methods: {
        zdarzenie: function(countryID) {
            this.$emit('testevent', countryID);

        },
        updateMap() {
            // console.log('Update Map')
            // console.log(this.map)
            this.map.color = '#fff'
            if (this.map.dataProvider == undefined) return;
            if (this.map == undefined) return;
            if (this.countries == undefined) return;
            let toja = this;
            for (var item in this.countries) {
                if (!(this.countries[item].cprice > 0)) {
                    continue;
                }
                var countryData = this.map.dataProvider.areas.find(function(el) {
                    if (el.id == toja.countries[item].ccode) {
                        // console.log("Found country:" + el.id)
                        return el;
                    }
                })
                if (countryData == undefined) {
                    countryData = {}
                }
                countryData.color = 'blue'
                countryData.id = this.countries[item].ccode;
                countryData.value = this.countries[item].cprice;
                countryData.selectable = true;

                // countryData.value =
                // console.log("Rob " + parseFloat(web3.fromWei(parseInt(this.countries[item].cprice),"ether")).toFixed(2));
                // console.log("Rob " + parseFloat(web3.fromWei(parseInt(this.countries[item].cprice),"wei")).toFixed(2));
                countryData.value = parseFloat(this.countries[item].cprice).toFixed(5)



                var len = this.countries[item].cowner.length;
                var myColor = this.countries[item].cowner.toString().substring(len - 4, len - 1)

                // countryData.color = '#001532'
                countryData.color = 'blue'

                if (this.$store.state.worldstate == 'alliance' || this.$store.state.worldstate == 'war') {
                    if (this.countries[item].alliance == 1) {
                        countryData.color = "#ff0000"
                        countryData.selectedColor = "#ff0000"
                        countryData.rollOverColor = "#081540"
                    }
                    if (this.countries[item].alliance == 2) {
                        countryData.color = "#0000ff"
                        countryData.selectedColor = "#0000ff"
                        countryData.rollOverColor = "#aa0000"

                    }
                    if (this.countries[item].alliance == 0) {
                        countryData.color = "#949599"
                        countryData.selectedColor = "#949599"
                        countryData.rollOverColor = "#707070"

                    }
                }
                if (this.$store.state.worldstate == 'peace') {
                    if (this.countries[item].cowner == this.$store.state.web3account) {
                        countryData.color = "#28DF01";
                        countryData.selectedColor = "#28DF01";
                        countryData.rollOverColor = "#1A9600"

                    } else {
                        {
                            countryData.color = "#FF6A01";
                            countryData.selectedColor = "#FF6A01";
                            countryData.rollOverColor = "#B44B00"

                        }
                    }
                }
                countryData.balloonText = '<p style="line-height:1; margin:10px;"><h5>[[title]]</h5><b>Price:</b> <u>[[value]]</u> </b>ETH</p>'
                countryData.balloonLabelFunction = null;

                // toja.map.dataProvider.areas.push(countryData);
            }
            // var area = toja.map.getObjectById('US');
            // area.showAsSelected = false;
            // toja.map.returnInitialColor(area);
            // toja.map.validateData();

            // console.log(this.$store.state.countries);

            // console.log(this.map.dataProvider.areas);
            // console.log('this.map.write')
            this.map.write(this.$el);
            // console.log('this.map.write')

        },
        drawMap() {
            function baloonFunction(country, graph) {
                if (country.value > 0) {
                    return country.title + " (" + country.id + ")<br><b>Price: " + country.value
                } else {
                  return country.title + " (" + country.id + ") is not yet available for sale"

                }
            }
            let tomoje = this;
            this.map = new AmCharts.AmMap()
            this.map.mouseWheelZoomEnabled = true
            this.map.balloonLabelFunction = baloonFunction
            this.map.projection = 'miller'
            this.map.addListener('clickMapObject', function(mapka) {
                tomoje.$emit('testevent', mapka.chart.selectedObject.id);
            });


            this.map.areasSettings = {
                unlistedAreasColor: '#fff',
                outlineColor: '#fff',
                color: '#555',
                outlineThickness: 1,
                selectedColor: 'blue',
                rollOverOutlineColor: '#222',
                autoZoom: false,
                selectable: false,
                balloonText: '[[title]] is not yet available for sale',
                rollOverColor: "#014261",
                balloonFunction: baloonFunction,
                balloonLabelFunction: baloonFunction
                    // color: '#085083  ',
            }


            var dataProvider = {
                map: 'worldLow',
                getAreasFromMap: true,
                images: [],
            }
            this.map.dataProvider = dataProvider;
            this.map.write(this.$el)
        }
    },
    computed: {
        updateMape: function() {
            return this.$store.state.updateMap;
        },
        countries: function() {
            return this.$store.state.countries;
        }
    },
    watch: {
        countries: function(val) {
            // console.log('Zaktualizowano countries w VectorMap')
            // console.log('Liczba krajow: ' + Object.keys(val).length)
            this.updateMap();
            // console.log(val[0].cname)
        },

        updateMape: function(val) {
            // console.log('UpdateMape:' + val)
            if (val == 1) {
                // console.log(this.kraje);
                this.updateMap();
                this.$store.state.updateMap = 0;
            }
        }

    },
    created: function() {

    },
    mounted() {
        this.drawMap();
        this.updateMap();
    }
}

</script>
