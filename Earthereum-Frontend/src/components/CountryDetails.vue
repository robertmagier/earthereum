<style scoped>

.fade-enter-active,
.fade-leave-active {
    transition: opacity .5s;
}

.fade-enter,
.fade-leave-to
/* .fade-leave-active below version 2.1.8 */

{
    opacity: 0;
}

.defended {
    font-size: 20px;
}

.noprogress {
    opacity: 0;
}

.progressvisible {
    opacity: 1;
}

.progress {
    transition: opacity 0.5s;
    font-size: 12px;
    vertical-align: middle;
    display: table-cell;
    /* border-style: solid; */
    line-height: 30px;
    /* width:2000px; */
    height: 30px;
    padding: 10px 0px 0px 0px;
    margin: 0px;
}

.progress img {
    display: inline-block;
    width: 20px;
    margin: 0px 0px 0px 0px;
}

.progress span {
    display: inline-block;
    vertical-align: middle;
    line-height: normal;
    /* border-style:solid; */
    margin: 0px;
    height: 100%;
}

.CountryDetails {
    /* z-index:10;; */
    /* transition: all 1s; */
    display: grid;
    border-style: solid;
    color: white;
    /* width: 560px; */
    /* height: auto; */
    padding: 15px;
    /* height:264px; */
    grid-auto-rows: min-content;
    grid-template-columns: 1fr 240px;
    text-align: left;
    /* background: #fff; */
    border-radius: 8px;
    border-width: 2px;
    border-color: #95989A;
    /* box-shadow: 2px 2px 3px 1px #085184; */
    /* background: linear-gradient(45deg, #fff, #aaa); */
    /* background-color:rgba(0,0,0,0.1); */
    margin: auto auto;
}

.CountryDetails:hover {
    /* bottom:5px; */
    /* box-shadow: 5px 9px 8px 1px #085184; */
    /* transform: translate3d(0, 50px, 0); */
}

.country-details-title {
    display: grid;
    grid-template-columns: 1fr 30px;
    grid-column: 1/3;
    grid-row: 1/2;
    /* width:350px; */
    /* border-style:solid; */
    font-size: 32px;
    font-weight: 900;
    padding: 5px 10px 0px 00px;
    color: #D90C1D;
    font-family: Gill Sans MT;
    font-style: normal;
    font-variant: normal;
    text-transform: uppercase;
    align-items: top;
}

.country-details-description {
    /* width: 250px; */
    grid-column: 1/2;
    /* border-style:solid; */
    grid-row: 1/3;
    padding: 0px 0px 0px 0px;
    color: #274052;
    font-size: 16px;
    margin: 10px 0px;
    font-weight: 500;
    /* text-shadow: 0px 3px 6px #000; */
    line-height: 1.6;
}

.country-details-picture {
    grid-column: 2/3;
    grid-row: 2/3;
    /* border-style:solid; */
    /* width:200px; */
    grid-row: 2/3;
    padding: 0px 0px 0px 0px;
    color: #274052;
    /* background-color:rgba(100,100,100,1); */
    /* width: 150px; */
}

.country-details-picture img {
    /* max-width:200px; */
    width: 100%;
    /* border-style:Solid; */
    /* position: relative;
      left:0px;
      top:00px; */
    /* box-shadow: 2px 4px 5px 1px #000; */
    /* border-radius:8px; */
}

.country-details-flag {
    /* width:auto; */
    /* height: auto; */
    grid-column: 2/3;
    /* border-style:solid; */
    grid-row: 3/4;
    /* padding: 0px 00px 0px 0px; */
    color: #274052;
    /* font-size: 12px; */
    /* font-weight: 400; */
    /* text-shadow: 0px 3px 6px #000; */
}

.country-details-flag img {
    width: 100%;
    /* border-style:solid; */
    /* position: relative; */
    /* left:0px; */
    /* top: -60px; */
    /* box-shadow: 2px 4px 5px 1px #000; */
    border-radius: 8px;
}

.country-details-btn {
    grid-row: 3/4;
    grid-column: 1/2;
    /* border-style:solid; */
    text-align: center;
    /* border-width:2px; */
    border-color: #95989A;
    background: #085184;
    width: 200px;
    height: 30px;
    border-radius: 4px;
    box-shadow: 2px 1px 3px 1px #000;
    margin: 0px 20px 20px 20px;
    color: #fafafa;
}

.country-details-attack {
    grid-column: 1/2;
    text-align: left;
    padding: 0px 0px 0px 0px;
    display: inline-block;
    border-color: #95989A;
    /* width: 250px; */
    height: auto;
    border-radius: 4px;
    margin: 0px 0px 0px 20px;
    color: #274052;
    font-weight: 600;
    text-decoration: none;
    line-height: 1.6;
    color: #274052;
    /* border-style:solid; */
    margin: 0px;
}

.country-details-attack ul {
    list-style-type: none;
    font-size: 14px;
    margin: 20px 20px 0px 20px;
    text-align: left;
    /* border-style:solid; */
    padding: 0px;
    color: #274052;
}

.country-details-attack li {
    list-style-type: none;
    font-size: 16px;
    margin: 0px 00px;
    text-align: left;
    /* border-style:solid; */
    padding: 0px;
    color: #274052;
}

.country-details-attack a {
    color: #274052;
    text-decoration: none;
}

.country-details-attack a:hover {
    color: #D90C1D;
}

.country-details-attack button {
    width: 150px;
    border-radius: 10px;
}

.country-details-btn-close {
    grid-row: 4/5;
    grid-column: 2/3;
    /* border-style:solid; */
    margin: ;
}

.country-details-btn a {
    color: #fff;
    font-weight: 400;
    font-size: 18px;
    font-style: normal;
    text-decoration: none;
}

.country-details-btn a:click {
    color: #fff;
    font-weight: 400;
    font-size: 16px;
    font-style: normal;
    text-decoration: none;
}

.map-font {
    color: black;
    font-size: 34px;
}

.map-font:hover {
    color: #085184;
    font-size: 34px;
}

.actionBox {
    color: black;
    border-width: 1px;
    /* border-style:solid; */
    border-radius: 5px;
    padding: 5px;
    margin: 0px 5px 0px 0px;
    text-align: center;
    font-weight: 800;
    color: #274052;
}

#closePopUp:hover {
    /* opacity:0.5; */
    filter: brightness(60%);
}

#closePopUp:active {
    /* opacity:0.5; */
    filter: brightness(20%);
}

</style>

<template>

<b-modal centered ok-only ok-title="Cancel" ok-variant="info" hide-footer no-close-on-esc size="lg" id="CountryDetails" show ref="CountryDetails" v-bind:title="'Details: '+tmpcountry.cname">
    <div class="CountryDetails">
        <div class="country-details-description">
            <b>Language:</b> {{tmpcountry.clang}}
            <br/> <b>Currency:</b> {{tmpcountry.ccur}}
            <br/> <b>Population:</b> {{tmpcountry.cpop}}
            <br/> <b>President:</b> {{tmpcountry.cpres}}
            <br/> <b>Capital City:</b> {{tmpcountry.ccap}}
            <br/> <b>Owner:</b> <span style="font-size:12px;font-weight:600;background-color:rgba(0,125,256,0.8);border-radius:5px;padding:5px">
              {{tmpcountry.owner}}  </span>
            <br/> <b>Price: {{tmpcountry.cprice}} ETH</b>
            <br/><span v-if="tmpcountry.attacks" style="color:red;"> Already attacked for {{tmpcountry.attacks}} % </span>
            <div style="width:40%;font-size:12px;font-weight:600;background-color:rgba(0,125,256,0);border-radius:5px;padding:10px 0px 0px 0px">

                <span v-if="progress">{{txsec}} sec </span> <img src="static/wait.gif" style="width:20px;vertical-align:middle" v-if="progress">
            </div>

            <span>{{message}}</span>
        </div>
        <div class="country-details-flag">
            <img :src="tmpcountry.cflag" alt="">
        </div>
        <div class="country-details-picture">
            <img :src="tmpcountry.cpic" alt="">
        </div>
        <div v-if="worldstate == 'war' && !friends && myCountriesCounter>0 && this.tmpcountry.ctype == 1" class="country-details-attack" style="">
            <ul>
                <li style="font-weight:800"> </li>
                <li v-if="tmpcountry.attacks<=24"><a href="#" v-on:click="AttackCountry(1)">Infantry Attack 1% <img src="/static/infantry_icon.png" alt="" style="height:20px"></a></li>
                <li v-if="tmpcountry.attacks<=20"><a href="#" v-on:click="AttackCountry(5)">Tank Attack 5% <img src="/static/tank_icon.png" alt="" style="height:15px"></a> </li>
                <li v-if="tmpcountry.attacks<=10"><a href="#" v-on:click="AttackCountry(15)">Fighter Attack 15% <img src="/static/fighter_icon.png" alt="" style="height:15px"></a> </li>
                <li v-if="tmpcountry.attacks==0"><a href="#" v-on:click="AttackCountry(25)">Nuclear Attack 25% <img src="/static/nuclear_icon.png" alt="" style="height:20px"></a> </li>
            </ul>

        </div>
        <div v-if="worldstate == 'war' && myCountriesCounter==0" class="country-details-attack" style="">
            You don't own any country. Sorry.
        </div>
        <div class="actionBox" v-if="friends && worldstate == 'war' && canbuy">
            You are friends !
            <br>
            <p style="font-size:12px; font-weight:400;">It is not possible to attack country from same alliance. </p>
        </div>
        <div v-if="worldstate == 'alliance' && myAlliance=='0'" class="country-details-attack" style="">
            <p style="color:red"> It is time to choose alliance now. Buying or attacking is not possible </p>
            {{myAlliance}}
        </div>
        <div v-if="worldstate == 'peace' && canbuy" class="country-details-attack" style="display:grid;grid-template-columns:1fr 1fr">
            <div style="width:200px;margin:5px 0px;">
                <b-button :disabled="!canbuy" @click="BuyCountry" variant="primary" style="float:left;padding:3px;width:150px; height:30px;grid-column:1/3">Buy </b-button>
            </div>


            <div style="grid-column:1/3">
                <p>Max price:</p>
                <b-form-input v-model="buyingPrice" step="0.0001" style="grid-column:1/3;margin:5px 0px;;height:30px; width:200px" type="number"></b-form-input>
            </div>
            <p style="grid-column:1/3"> Buy this country for <span style="white-space: nowrap;">  <b>{{tmpcountry.cprice}}&nbsp;ETH</b></span>. After this it's price is going to increase by 15%. You can also provide maximum price for which you are willing to buy.</p>
        </div>

        <div v-if="!canbuy && (worldstate == 'peace')" class="actionBox">
            <span style="font-size:12px; font-weight:800;" v-if="!canbuy && (worldstate != 'alliance')">You are the owner of this country.</span>

        </div>
        <div v-if="iAmOwner && (worldstate == 'alliance') && myAlliance>0 &&  this.tmpcountry.ctype==1" class="actionBox country-details-attack">
            <!-- <span style="font-size:12px; font-weight:800;">Buy defense</span> -->
            <ul>
                <li style="font-weight:800"></li>
                <li><span v-if="tmpcountry.d1">&#10004; Infantry Defense 1%</span><a v-if="!tmpcountry.d1" href="#" v-on:click="BuyDefense(1)">Infantry Defense 1% <img src="/static/infantry_icon.png" alt="" style="height:20px"></a></li>

                <li><span v-if="tmpcountry.d5">&#10004; Tank Defense 5%</span><a v-if="!tmpcountry.d5" href="#" v-on:click="BuyDefense(5)">Tank Defense 5% <img src="/static/tank_icon.png" alt="" style="height:15px"></a> </li>

                <li><span v-if="tmpcountry.d15">&#10004; Fighter Defense 15%</span><a v-if="!tmpcountry.d15" href="#" v-on:click="BuyDefense(15)">Fighter Defense 15% <img src="/static/fighter_icon.png" alt="" style="height:15px"></a> </li>

            </ul>
        </div>
        <div v-if="iAmOwner && (worldstate == 'war') && tmpcountry.ctype==1" class="actionBox country-details-attack">
            <!-- <span style="font-size:12px; font-weight:800;">Buy defense</span> -->
            <ul>
                <li style="font-weight:800"></li>
                <li>
                    <span v-if="tmpcountry.d1">&#10004;</span>
                    <span v-if="!tmpcountry.d1">&#10060;</span>
                    <span> Infantry Defense 1%</span></li>

                <li>
                    <span v-if="tmpcountry.d5">&#10004;</span>
                    <span v-if="!tmpcountry.d5">&#10060;</span>
                    <span> Tank Defense 5%</span></li>

                <li>
                    <span v-if="tmpcountry.d15">&#10004;</span>
                    <span v-if="!tmpcountry.d15">&#10060;</span>
                    <span> Fighter Defense 15%</span></li>

            </ul>
        </div>



    </div>
</b-modal>

</template>

<script>

import Vue from 'vue';
import VueResource from 'vue-resource'
import bButton from 'bootstrap-vue/es/components/button/button';
Vue.component('b-button', bButton);
import bForm from 'bootstrap-vue/es/components/form/form';
Vue.component('b-form', bForm);
// import { store } from '../storage/store'

export default {
    name: 'CountryCard',

    data() {
        return {
            countries: [],
            tmpcountry: {},
            // progress: false,
            cprice: 0,
            message: '',
            buytx: null,
            waiting: false,
            txsec: 0,
            actionUpdate: '',
            canbuy: true,
            buyingPrice:0
        }
    },
    props: {
        ccode: '',
        active: false,
        country: {
            type: Object,
            default: () => ({})
        },

    },
    computed: {
        myCountriesCounter: function() {
            return this.$store.state.myCountriesCounter;
        },
        myAlliance: function() {
            return this.$store.state.alliance;
        },

        friends: function() {
            if (this.tmpcountry.alliance != undefined) {
                return (this.tmpcountry.alliance.toString() == this.$store.state.alliance.toString())
            } else {
                return true;
            }
        },
        progress: function() {

            // console.log('this buytx =' + this.buytx)
            // console.log(this.buytx)
            if (this.$store.state.web3account == this.tmpcountry.cowner) {
                return false;
            }
            return (this.buytx != null)
        },
        worldstate: function() {
            return this.$store.state.worldstate;
        },

        iAmOwner: function() {
            return (this.$store.state.web3account == this.tmpcountry.cowner)
        },
        price: function()
        {
          var price = this.tmpcountry.cprice;
          console.log(price)
          price = Math.ceil(price*10000)
          console.log(price)
          price = price / 10000
          console.log(price)
          return price

        }

    },
    methods: {
        CheckTransaction(txhash) {
                let that = this;
                this.buytx = txhash
                    // console.log("Check Transaction");
                var status = web3.eth.getTransactionReceipt(txhash, function(err, res) {
                    // console.log("Transaction Receipt Status:")
                    // console.log(res);
                    // console.log("Transaction Receipt Error:")
                    // console.log(err);
                    if (err) {
                        that.buytx = null;
                        that.txsec = 0;
                        that.message = "Transaction was cancelled."
                            // console.log(err)
                        return;
                        alert("Transaction errored");
                        that.GetCountryOwner();
                        that.GetCountryPrice();
                        that.buytx = null;

                    }

                    if (res == null) {
                        that.txsec++;
                        setTimeout(function() {
                            that.CheckTransaction(that.buytx);
                        }, 1000);
                        return;
                    }
                    if (res) {
                        that.txsec=0;
                        // alert("transaction completed");
                        that.$store.state.storageVersion++;
                        that.GetCountryOwner();
                        that.GetCountryPrice();
                        that.$store.dispatch('updateBlockChainData');
                        setTimeout(function() {
                            that.buytx = null;
                        }, 2000);
                        return;
                    }
                });

            },
            BuyCountry: function() {
                let that = this;
                // console.log("Buy")
                // console.log(this.$store.web3contract)
                // console.log(this.ccode);

                this.$store.web3contract.BuyCountry(this.ccode, {
                    value: web3.toWei(this.buyingPrice, "ether")
                }, function(err, res) {
                    // console.log(res);
                    that.buytx = res;
                    that.message = ''
                    that.CheckTransaction(res);
                })
            },
            hidePopUp: function() {
                this.$emit('testevent');
                // console.log("Close this shit")
            },
            Attack(val) {
                // console.log('Attacking Country ' + this.tmpcountry.cname + " " + val * 100 + "% ETH:" + this.tmpcountry.cprice * val);
                var information = {
                    from: 'US',
                    to: this.tmpcountry.ccode,
                    attackValue: val,
                    timestamp: Date.now()
                }
                this.$store.state.news.unshift(information);
                this.$store.state.warpool += this.tmpcountry.cprice * val;
                // this.$store.commit('setWarPool',this.tmpcountry.cprice * val)
                this.tmpcountry.cprice -= this.tmpcountry.cprice * val;
                this.tmpcountry.cprice = parseFloat(this.tmpcountry.cprice).toFixed(6);
                // console.log("Store");
                // console.log(this.$store);

            },
            AttackCountry(val) {
                // console.log("Attack COUNTRY !!!!!!!!!!!!!!!!!!!!!!!!!!!")
                let that = this;
                var amount = this.tmpcountry.cprice * val / 100
                    // console.log(val +' ' +amount)
                    amount = Math.floor((amount + 0.00001)*100000)/100000
                    console.log(amount)
                this.$store.web3contract.AttackCountry(this.ccode, val, {
                    value: web3.toWei(amount, "ether")
                }, function(err, res) {
                    // console.log(err)
                    // console.log(res);
                    that.buytx = res;
                    that.message = ''
                    that.CheckTransaction(res);
                })

            },
            BuyDefense(val) {
                let that = this;
                var amount = this.tmpcountry.cprice * val / 1000
                amount = (amount + 0.000002).toFixed(6);
                // console.log(val +' ' +amount)
                // console.log("BUY DEFENSE:" +  amount);
                this.$store.web3contract.BuyDefense(this.ccode, val, {
                    value: web3.toWei(amount, "ether")
                }, function(err, res) {
                    // console.log(err)
                    // console.log(res);
                    that.buytx = res;
                    that.message = ''
                    that.CheckTransaction(res);
                })

            },
            GetCountryPrice() {
                let that = this;
                if (this.$store.web3contract == undefined) {
                    return;
                }
                this.$store.web3contract.GetCountryPrice(that.ccode, function(err, res) {
                    if (err != undefined) {
                        that.cprice = "ERROR";
                    } else {
                        that.cprice = web3.fromWei(res[0].toNumber());
                        that.cprice = Math.ceil(that.cprice*10000)/10000
                    }

                });
            },
            GetCountryOwner() {
                let that = this
                if (this.$store.web3contract == undefined) {
                    return
                }
                this.$store.web3contract.GetCountryOwner(that.ccode, function(err, res) {
                    console.log('GetCountryOwner')
                    console.log(res)
                    console.log(err);
                    if (err != undefined) {
                        // that.cowner = "ERROR"
                    } else {
                        that.tmpcountry.cowner = res[0];
                    }
                    if(that.tmpcountry.cowner == that.$store.state.web3account)
                    {
                      that.tmpcountry.owner = "You are the owner";
                      that.canbuy = false;
                    }
                    else {
                      that.tmpcountry.owner = that.tmpcountry.cowner;
                      that.canbuy = true;
                    }
                })
            },

            GetCountryInformation: function(ccode) {
                let tmp;
                this.message = ''
                if (this.country != undefined) {
                    this.tmpcountry = this.country;
                    this.tmpcountry.cflag = this.$config.API + '/getFlag?ccode=' + this.tmpcountry.ccode;
                    this.tmpcountry.cpic = this.$config.API + '/getCountryPicture?ccode=' + this.tmpcountry.ccode;

                }
                if (this.ccode.length > 0) {
                    // console.log('szukamkraju:' + this.ccode)
                    let cod = this.ccode;
                    tmp = this.$store.state.countries.find(function(obj) {
                            return (obj.ccode == cod)


                        })
                        // console.log(tmp);
                    this.tmpcountry = tmp;
                    if(this.tmpcountry.cowner == this.$store.state.web3account)
                    {
                      this.tmpcountry.owner = "You are the owner";
                      this.canbuy = false;
                    }
                    else {
                      this.tmpcountry.owner = this.tmpcountry.cowner;
                      this.canbuy = true;
                    }
                    this.tmpcountry.cflag = this.$config.API + '/getFlag?ccode=' + this.tmpcountry.ccode;
                }
            }


    },
    created: function() {
    },
    watch: {
        price: function(val)
        {
          this.buyingPrice = val
        },
        ccode(val) {
                this.GetCountryInformation(val);
            },
            active: function(val) {
                this.GetCountryInformation(this.ccode)
                this.$refs.CountryDetails.show();

            }
    },
    events: {
        testevent: function(e) {
        }
    }
}

</script>
