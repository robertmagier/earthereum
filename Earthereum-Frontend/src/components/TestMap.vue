<style>

@import "leaflet/dist/leaflet.css";
body {
    background-color: #fff;
    margin-left: 100px;
    margin-right: 100px;
}

#map {
    background-color: #eee;
}

</style>

<template>

<div id="app">
    <v-map :center="[30, 10]" :zoom="1" style="height: 400px; width:800px;opacity:1" :options="mapOptions">
        <v-choropleth-layer :data="pyDepartmentsData" titleKey="name" idKey="id" :value="value" :extraValues="extraValues" geojsonIdKey="dpto" :geojson="paraguayGeojson" :colorScale="colorScale">
            <template slot-scope="props">
                <v-info-control :item="props.currentItem" :unit="props.unit" title="Department" placeholder="Hover overs a department" />
                <v-reference-chart title="Girls school enrolment" :colorScale="colorScale" :min="props.min" :max="props.max" position="bottomright" />
            </template>
        </v-choropleth-layer>
    </v-map>
</div>

</template>

<script>

import {
    InfoControl, ReferenceChart, ChoroplethLayer
}
from 'vue-choropleth'
import {
    geojson
}
from './data/py-departments-geojson'
    // import paraguayGeojson from './data/paraguay.json'
import paraguayGeojson from './data/countries.geo.json'
    // import paraguayGeojson from './data/countries.geo.json'
    // import { pyDepartmentsData } from './data/py-departments-data'
import {
    pyDepartmentsData
}
from './data/countries.data'
import Vue2Leaflet from 'vue2-leaflet';
export default {
    name: "app",
    components: {
        'v-map': Vue2Leaflet.Map,
        'v-info-control': InfoControl,
        'v-reference-chart': ReferenceChart,
        'v-choropleth-layer': ChoroplethLayer
    },
    data() {
        return {
            pyDepartmentsData,
            paraguayGeojson,
            colorScale: ["e7d090", "e9ae7b", "de7062"],
                value: {
                    key: "amount_w",
                    metric: "% girls"
                },
                extraValues: [{
                    key: "amount_m",
                    metric: "% boys"
                }],
                mapOptions: {
                    attributionControl: false
                }
        }
    },
}

</script>
