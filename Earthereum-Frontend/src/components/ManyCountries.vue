<style scoped>

@import '../style2.css';

.zeroCountries {
  /* background-color:red; */
  color:#fafafa;
  font-size:20px;
  font-weight:600;
  width:200%;
  margin:10% 100%;
  background-color:rgba(0,0,0,0.2);
  padding:20px;
  word-wrap:break-word;
  text-align:center;
  border-radius:10px;

}

</style>

<template>

<div id="ManyCountries" class="CountryCards">

    <div class="countries-cards">
        <div/>
        <div class="countries-sort" v-if="countriesCount">
            <center>

                <input class="sort-input" v-on:click="sortByName" type="radio" name="sort-order" value="1"> Price Ascending
                <input class="sort-input" v-on:click="sortByName" type="radio" name="sort-order" value="2"> Price Descending
                <input class="sort-input" v-on:click="sortByName" type="radio" name="sort-order" value="3"> Name Ascending
                <input class="sort-input" v-on:click="sortByName" type="radio" name="sort-order" value="4"> Name Descending
            </center>
        </div>


        <CountryCard v-on:testevent="testevent($event)" v-for="country in countries" v-if="(!onlyOwned || (country.cowner == web3account))&&(country.cprice > 0)" :key="country.ccode" :country="country"></CountryCard>

    </div>
    <div v-if="!countriesCount" class="CountryCards zeroCountries">
      <p> You don't own any country yet. Please go back to the World Map and buy it!</p>
    </div>
</div>

</template>

<script>

import CountryCard from "./CountryCard"


export default {
    name: 'ManyCountries',

    data() {
        return {
            newUser: {},
            users: [],
            country_old: {
                cname: "USA",
                clang: "English",
                ccur: "USA",
                cpop: "300 mln",
                cpres: "Donald Trumph",
                ccap: "Washinghton DC",
                cowner: "Owner Lost",
                cprice: "1.01 ETH",
                cflag: "/static/usflag.png",
                cpic: "/static/uspicture.png"
            }
        }
    },
    props: {
        onlyOwned: false,

    },
    methods: {
        testevent(countryID) {
                this.$emit('testevent', countryID)

            },
            sortByName: function(e) {
                // alert(this.$refs.selector.value);
                // console.log(e.target.value);
                // console.log(new Date().getTime());
                // console.log(e.target.value)
                // console.log(this.countries);
                switch (Number(e.target.value)) {
                    case 1: //Price Ascending
                        this.countries.sort(function(a, b) {
                            var valueA = Number(a.cprice); // ignore upper and lowercase
                            var valueB = Number(b.cprice); // ignore upper and lowercase
                            // console.log(valueA +" \ " + valueB);
                            if (valueA > valueB) {
                                return 1;
                            }
                            if (valueA < valueB) {
                                return -1;
                            }
                            return 0;

                        });
                        break;
                    case 2:
                        this.countries.sort(function(a, b) {

                            var valueA = Number(a.cprice); // ignore upper and lowercase
                            var valueB = Number(b.cprice); // ignore upper and lowercase
                            if (valueA > valueB) {
                                return -1;
                            }
                            if (valueA < valueB) {
                                return 1;
                            }
                            return 0;
                        });
                        break;
                    case 3:
                        this.countries.sort(function(a, b) {
                            var nameA = a.cname.toUpperCase(); // ignore upper and lowercase
                            var nameB = b.cname.toUpperCase(); // ignore upper and lowercase
                            if (nameA < nameB) {
                                return -1;
                            }
                            if (nameA > nameB) {
                                return 1;
                            }
                            return 0;
                        });
                        break;
                    case 4:
                        this.countries.sort(function(a, b) {
                            var nameA = a.cname.toUpperCase(); // ignore upper and lowercase
                            var nameB = b.cname.toUpperCase(); // ignore upper and lowercase
                            if (nameA < nameB) {
                                return 1;
                            }
                            if (nameA > nameB) {
                                return -1;
                            }
                            return 0;
                        });
                        break;
                    default:
                        break;
                }
            }


    },
    computed: {
        countries: function() {
            return this.$store.state.countries;
        },
        web3account: function() {
            return this.$store.state.web3account;
        },
        countriesCount: function() {
            var counter = 0;
            if (this.onlyOwned == false) {
                return this.countries.length;
            } else {
                for (var item in this.countries) {
                    if (this.countries[item].cowner == this.web3account) {
                        counter += 1;
                    }
                }
                return counter;
            }
        }

    },
    components: {
        CountryCard
    },
    created: function() {
        var apiAdr = this.$config.API + '/getCountries'
            // this.$http.get(apiAdr).then(function(response){
            // console.log(response.data);
            //  this.countries = response.data;
            // })
        // this.countries = this.$store.state.countries;
    }
}

</script>
