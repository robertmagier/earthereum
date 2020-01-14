<style lang="css">

#test {
    display: grid;
    grid-template-columns: 1fr 3fr 3fr;
    grid-gap: 10px;
    vertical-align: bottom;
    align-items: center;
    align-content: center;
    color: black;
    width: 800px;
    /* height: 300px; */
    /* border-style: solid; */
    text-align: center;
    margin: 40px;
}

.mine {}


/* p {
    border-style: solid;
    display: table-cell;
    vertical-align: middle;
    text-align: center;
} */

</style>

<template lang="html">

<div id="test">
    <b-button @click="GetCountryPrice" variant="primary" class="mine">GetCountryPrice</b-button>
    <b-form-input v-model="countryCode"></b-form-input>
    <b-form-input disabled v-model="countryPrice"></b-form-input>

    <b-button @click="GetCountryOwner" variant="primary" class="mine">GetCountryOwner</b-button>
    <b-form-input v-model="countryCode" ></b-form-input>
    <b-form-input v-model="countryOwner" disabled></b-form-input>

    <b-button variant="primary" class="mine">GetCountriesCount</b-button>
    <b-form-input ></b-form-input>
    <b-form-input disabled></b-form-input>

    <b-button variant="primary" class="mine">GetCountries</b-button>
    <b-form-input ></b-form-input>
    <b-form-input disabled></b-form-input>

    <b-button variant="primary" class="mine">GetBalance</b-button>
    <b-form-input > </b-form-input>
    <b-form-input disabled> </b-form-input>

    <b-button @click="Mint"  variant="danger" class="mine">Mint</b-button>
    <b-form-input v-model="newCountryCode"></b-form-input>
    <b-form-input disabled></b-form-input>

    <b-button @click="MintAll"  variant="danger" class="mine">Mint All</b-button>
    <b-form-input v-model="newCountryCode"></b-form-input>
    <b-form-input disabled></b-form-input>

    <b-button @click="BuyCountry" variant="danger" class="mine">BuyCountry</b-button>
    <div style="display:grid;grid-template-columns: 1fr 1fr 1fr 1fr">Country Code:
        <b-form-input v-model="buyCountryCode"></b-form-input>Value:
        <b-form-input v-model="buyValue"></b-form-input>
    </div>
    <b-form-input v-model="buyTransaction"></b-form-input>

    <b-button variant="danger" class="mine">WithdrawMoney</b-button>
    <b-form-input></b-form-input>
    <b-form-input disabled></b-form-input>

</div>

</template>

<script>

import Vue from 'vue';
import './contractdef'
import bFormInput from 'bootstrap-vue/es/components/form-input/form-input';
Vue.component('b-form-input', bFormInput);
import bButton from 'bootstrap-vue/es/components/button/button';
Vue.component('b-button', bButton);
// import Web3 from 'web3'

export default {
    name: 'web3',
    data() {
        return {
            text: 'test',
            testweb3output: 'test test test ',
            web3contract: {},
            countryPrice: 0,
            countryCode:'US',
            countryOwner:'',
            newCountryCode:'',
            buyCountryCode:'',
            buyValue:0,
            buyTransaction:'ddd'

        }
    },
    methods: {
      BuyCountry() {
        // var mw = new Web3()
        // console.log(mw)
        // return
        let that = this

        this.buyTransaction = this.web3contract.BuyCountry(this.buyCountryCode,{gas:3000000,value:window.web3.toWei( 10.15, 'ether')},(err,res)=>{
          console.log(res)
          that.buyTransaction = res
          // console.log(err)

        })
        // this.web3contract.BuyCountry(this.buyCountryCode,{value:this.buyValue},(err,res)=>{
        //   console.log(res)
        //   console.log(err)
        //
        // })
      },
      Mint() {
        console.log(this.newCountryCode)
        console.log("MINT");

        var tx = this.web3contract.Mint(this.newCountryCode,1,"",0,(err,res)=>{
          console.log(res);
          console.log(err);

        })
      },
      MintAll() {
        console.log(this.newCountryCode)
        console.log("MINT");

        var tx = this.web3contract.MintDefaultCountries({from:'0x6ec0fcdd6523D43972c5b122Ae12F616e3e56cAA'},(err,res)=>{
          console.log(res);
          console.log(err);

        })
      },
        GetCountryPrice() {
          let that = this
                // this.countryPrice = this.countryCode
                console.log(this.countryCode);
                this.countryPrice = this.web3contract.GetCountryPrice(this.countryCode,function(err,res){
                  that.countryPrice = res[0].toNumber();
                  that.countryPrice = web3.fromWei(res[0].toNumber(),"ether");
                  // console.log(err)
                })

            },
        GetCountryOwner() {
          let that = this
                // this.countryPrice = this.countryCode
                  this.web3contract.GetCountryOwner(this.countryCode,function(err,res){
                  that.countryOwner = res;
                  console.log(err)
                })

            },
            testweb3: function() {
                // let that = this
                // console.log(web3)
                // window.web3.version.getNetwork(function(err, netId) {
                //     that.testweb3output = netId;
                // })
                // this.testweb3output = window.web3.eth.getcoinbase
                //     // this.testweb3output = 'test'

                // console.log(web3)
                // console.log(window.web3)
                // console.log(window.web3.eth.defaultAccount)

            },
            getAccount: function() {
                this.text = window.web3.eth.defaultAccount
                    // console.log(window.web3.eth)
                    // console.log(this.text)
                let that = this
                    // setTimeout(function(){that.getAccount()},1000)
            }
    },
    created: function() {
        var myweb3 = new Web3(web3.currentProvider);
        var testContract = myweb3.eth.contract(smartContract)
        this.web3contract = testContract.at('0xB6C3eF351D25d5d56a9dBC5673766874BCE89e2c')

    },
    computed: {
        test: function() {
            return window.web3.eth.defaultAccount
        }
    }
}

</script>
