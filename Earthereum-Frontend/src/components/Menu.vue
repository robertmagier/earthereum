<style scoped>

@import '../style2.css';
.alliance {
    /* border-style: solid; */
    border-width: thin;
    border-radius: 10px;
    display: grid;
    grid-gap: 5px;
    background-color: rgba(255, 255, 255, 0.5);
    grid-template-columns: 1fr 1fr;
    /* width:100%; */
    /* background-color: #1C5060; */
}

.ally {
    background-color: #fafafa;
    padding: 5px;
    border-style: solid;
    border-width: thin;
    border-radius: 5px;
    /* margin:5px; */
    width: 100%;
}

.opac {
  transition: all 2s;
  opacity:0;
}

.disabled {
  background-color:grey;
  border-color:grey;
}

.debug-information {
  opacity:0;
}

</style>

<template>

<div id="Menu" class="main-nav">

    <b-modal :no-close-on-esc="!blockactivity" :no-close-on-backdrop="blockactivity" :hide-header-close="blockactivity" size="lg" ref="myModalRef" v-bind:visible="showAllianceCheck" variant="danger" centered hide-footer title="Choose your Alliance">

       <b-alert  :show="!upToDate" variant="info">Receiving information about your account from blockchain...</b-alert>
       <b-alert v-if="blockactivity" show variant="danger">Your account <b style=":hover {color:red;}">{{web3account}} </b> doesn't own any country. Therefore you are not allowed to choose alliance and participate in war. </b-alert>
        <div class="alliance">
            <div class="ally">
                <center>Alliance #1</center>
                <ul style="list-style:none">
                    <li>Name: {{alliance1Name}}</li>
                    <li>Countries: {{alliance1Counter}} {{alliance1Countries}}</li>
                    <li> Total value: {{alliance1Value}} ETH </li>
                </ul>

                <b-button  class="mt-3" :disabled="blockactivity || !upToDate || !alliance1Active" variant="danger" block @click="ChooseAlliance(1,alliance1Name)"><span>Choose</span></b-button>

            </div>
            <div class="ally">
                <center>Alliance #2</center>
                <ul style="list-style:none">
                    <li>Name: {{alliance2Name}}</li>
                    <li>Countries: {{alliance2Counter}} {{alliance2Countries}} </li>
                    <li> Total value: {{alliance2Value}} ETH </li>
                </ul>
                <b-button  class="mt-3" variant="primary" block :disabled="blockactivity || !upToDate || !alliance2Active" @click="ChooseAlliance(2,alliance2Name)">Choose</b-button>
            </div>
        </div>
        <center>
            <span style="font-size:12px;color:red" v-if="!alliance1Active || !alliance2Active"> One of alliances was blocked becuase there is too big value difference between Alliance #1 and Alliance #2. </span>
            <p style="margin:5px;color:grey">Press ESC to close this window and have some time for thinking.</p>
        </center>

    </b-modal>
    <b-modal ref="networkModal" v-bind:visible="showNetworkModal" size="lg" hide-footer no-close-on-esc no-close-on-backdrop hide-header-close hide-header centered>
        <div style="width:100%;color:red;font-size:20px;background-color:rgba(200,200,200,0.7);border-radius:5px;padding:20px;">
            <center>
                <p v-if="!metaMaskInstalled"> It seems MetaMask is not installed in your browser or you didn't log in.
                    <br>You can add this extension
                    <a href="https://metamask.io/">here. </a> </p>
            </center>
            <center>
                <p v-if="metaMaskInstalled"> Earthereum is currently working with local network only. Selected network is {{web3network}}.
                    <br>
                    <br><b>Please change it in MetaMask. </b></p>
            </center>
        </div>
    </b-modal>
    <div class="main-nav-header">
        <a href="">
            <img src="/static/Logolight.png" style="width:200px;" alt="">
        </a>
    </div>
    <div class="main-nav-links">
        <ul>

            <li>
                <router-link v-if="isAuthorized" @click.native="CheckAlliance()" to="admin">ADMINISTRATION</router-link>
            </li>
            <li>
                <router-link @click.native="CheckAlliance()" to="map">WORLD MAP</router-link>
            </li>
            <li>
                <router-link @click.native="CheckAlliance()" to="myoperation">MY OPERATION</router-link>
            </li>
            <li>
                <router-link @click.native="CheckAlliance()" to="statistics">Statistics</router-link>
            </li>
            <li>
                <router-link @click.native="CheckAlliance()" to="faq">FAQ</router-link>
            </li>
            <li>
                <router-link @click.native="CheckAlliance()" to="about">ABOUT</router-link>
            </li>

            <li style="color:white;font-weight:800;" v-bind:class="{opac:!refreshing}">
            Updating:   <img src="static/wait.gif" style="width:20px;vertical-align:middle" v-bind:class="{opac:!refreshing}">
            </li>
            <li class="debug-information">
                <button style="border-radius:5px;background-color:blue;border-width:1px;padding:5px; border-color:black "  @click="refresh()"> Refresh </button>
            </li>
            <li>
            <div>


            <li  class="debug-information">
                Your alliance: {{alliance}}
            </li>
            <li  class="debug-information">
                Account: {{web3account}}
            </li>

            <li  class="debug-information">
                Network: {{web3network}}
            </li>
            <li class="debug-information">
                Owner: {{gameOwner}}
            </li>
          </div>
        </li>
        </ul>

    </div>

</div>

</template>

<script>

function hex2a(hexx) {
    var hex = hexx.toString();//force conversion
    var str = '';
    for (var i = 2; i < hex.length; i += 2)
        str += String.fromCharCode(parseInt(hex.substr(i, 2), 16));
    return str;
}

import './contractdef'
import Vue from 'vue'
import bModal from 'bootstrap-vue/es/components/modal/modal';
Vue.component('b-modal', bModal);
import vBModal from 'bootstrap-vue/es/directives/modal/modal';
Vue.directive('b-modal', vBModal);
import bAlert from 'bootstrap-vue/es/components/alert/alert';
Vue.component('b-alert', bAlert);
export default {
    name: 'Menu',

    data() {
        return {
            newUser: {},
            users: [],
            web3account: '',
            web3network: '',
            showNetworkModal: false,
            metaMaskInstalled: false,
            metaMaskMessage: '',
            checkerNumber: 0,
            buyEventsData:[],
            newsEventsData:[],
            worldstateEventsData:[],
            countryAttackEventsData:[],
            blocksTime:{},
            buyEvent:null,
            WorldStateChangeEvent:null,
            AllianceChangedEvent:null,
            WarResultEvent:null,
            UserWarShareEvent:null,
            countryAttackedEvent:null,
            NewDefenseEvent:null,
            ucinterval:null,
            gainterval:null
        }
    },
    props: {
        cname: {
            type: String,
            default: 'Foobar'
        },
        cdescription: {
            type: String,
            default: 'Foobar'
        },
        flag: {
            type: String,
            default: 'Foobar'
        },
        picture: {
            type: String,
            default: 'Foobar'
        },

    },
    methods: {
        defaultHandler: function(err,res,name,level) {
          level = 1
          var reporting = true;

          if(reporting && level == 1 )
          {
            console.log("###########:"+name+":############");
            if(err)
            {
              console.log("Error:")
              console.log(err);
            }
            else {
              console.log("Result:")
              console.log(res);
            }
          }
        },

        allEventsHandler: function (err,res){
          this.defaultHandler(err,res,"All Events")
        },

        RegisterEvent: function(_txhash,_logIndex)
        {
          console.log('Register Event:' + _txhash)
          var entry = this.$store.state.eventsHash.find(function(el){
            if(el.txhash == _txhash && el.logIndex == _logIndex)
            {
              return el;
            }
            else {
              return null;
            }
          })

          if ( entry == null)
          {
            var e1 = {};
            e1.txhash = _txhash;
            e1.logIndex = _logIndex
            this.$store.state.eventsHash.push(e1)
            return true;
          }
          else
          {
            return false;
          }
        },
        AddNewsEntry:function(_type, _ccode, _cprice, _blockNumber,_defended,_extra_value,_txhash){
          var newsEntry = {};
            newsEntry.type=_type;
            newsEntry.ccode=_ccode;
            newsEntry.cprice = _cprice;
            newsEntry.value = _cprice;
            newsEntry.secondaryvalue = _extra_value;
            newsEntry.blockNumber = _blockNumber;
            newsEntry.defended = _defended;
            newsEntry.timestamp = this.GetBlockTime(_blockNumber);
            this.$store.state.newsEventsData.push(newsEntry);
        },
        GetBlockTime: function(_blockNumber) {
          if(this.$store.state.blocksTime[_blockNumber]){
            return this.$store.state.blocksTime[_blockNumber];
          }
          var timestring =  undefined
          let that = this;

          web3.eth.getBlock(_blockNumber,function(err,res){
            if(!err)
            {
              var ts = res.timestamp;
              that.$store.state.blocksTime[_blockNumber] = ts;
              that.$store.state.newTime = true;

            }
          })
          return timestring;
        },

        CountryAttackedHandler: function (err,res) {

          if(this.RegisterEvent(res.transactionHash,res.logIndex))
          {
          this.defaultHandler(err,res,"Country Attack",1);
          var countryAttackedData={};
          countryAttackedData.attacker = res.args._attacker;
          countryAttackedData.ccode = hex2a(res.args._CR).substr(0,2);
          countryAttackedData.attackType = res.args._attackType;
          countryAttackedData.attackValue = web3.fromWei(res.args._attackvalue,"ether").toNumber();
          countryAttackedData.defended = res.args.defended;
          countryAttackedData.blockNumber = res.blockNumber;
          countryAttackedData.timestamp = this.GetBlockTime(res.blockNumber);

          this.AddNewsEntry("attack",countryAttackedData.ccode,countryAttackedData.attackType.toNumber(),res.blockNumber,res.args.defended,0,res.transactionHash);

          this.$store.state.countryAttackEventsData.push(countryAttackedData);
          this.$store.state.storageVersion = this.$store.state.storageVersion +1
        }

        },
        // event WarResult(uint winner, uint a1value, uint a2value, uint timestamp);
        // event UserWarShare(address user, uint share, uint value, uint timestamp);
        WarResultHandler: function (err,res) {
          if(this.RegisterEvent(res.transactionHash,res.logIndex))
          {
          this.defaultHandler(err,res,"War Result",1);


          if (this.$store.state.warResultsEventsData[res.args.timestamp] == undefined)
          {
            var WarResultData = {};
            WarResultData._blockNumber = res.blockNumber;
            WarResultData.winner = res.args.winner;
            WarResultData.a1value = res.args.a1value;
            WarResultData.a2value = res.args.a2value;
            WarResultData.timestamp = res.args.timestamp;
            WarResultData.usersshares=[];
            this.$store.state.warResultsEventsData[res.args.timestamp] = WarResultData;
          }
          else {
            this.$store.state.warResultsEventsData[res.args.timestamp].winner = res.args.winner;
            this.$store.state.warResultsEventsData[res.args.timestamp].a1value = res.args.a1value;
            this.$store.state.warResultsEventsData[res.args.timestamp].a2value = res.args.a2value;
            this.$store.state.warResultsEventsData[res.args.timestamp].timestamp = res.args.timestamp;
          }
          if(res.args.winner == 0)
          {
            this.AddNewsEntry("draw",'',0,res.blockNumber,false,0,res.transactionHash);

          }
          this.$store.state.storageVersion = this.$store.state.storageVersion +1;


          // console.log(this.$store.state.warResultsEventsData)
        }
        },
        UserWarShareHandler: function (err,res) {
          if(this.RegisterEvent(res.transactionHash,res.logIndex))
          {
          this.defaultHandler(err,res,"User War Share",1);
          var UserShareData = {};
          UserShareData.timestamp = res.args.timestamp;
          UserShareData.timestring = new Date(res.args.timestamp*1000).toLocaleString();
          UserShareData.user = res.args.user;
          UserShareData.share = res.args.share;
          UserShareData.value = res.args.value;
          UserShareData.valueETH = web3.fromWei(res.args.value,"ether").toFixed(6) + ' (Attacks: #'+ res.args.attacksNumber +')';
          if (this.$store.state.warResultsEventsData[res.args.timestamp] == undefined)
          {
            this.$store.state.warResultsEventsData[res.args.timestamp]={};
            this.$store.state.warResultsEventsData[res.args.timestamp].usersshares = [];
          }

          this.$store.state.warResultsEventsData[res.args.timestamp].usersshares.push(UserShareData)
          // console.log(this.$store.state.warResultsEventsData[res.args.timestamp].usersshares)
        }
        },
        WorldStateChangeHandler: function (err,res) {
          if(!this.RegisterEvent(res.transactionHash,res.logIndex))
          {
            //do nothing if this event is already registered
            return;
          }

          this.defaultHandler(err,res,"World State Change");


          this.AddNewsEntry("state",' ',res.args._newstate,res.blockNumber,false,0,res.transactionHash);

          var worldStateData={};
          worldStateData.blockNumber = res.blockNnumber;
          worldStateData.timestamp = this.GetBlockTime(res.blockNnumber)
          worldStateData.state = res.args._newstate;
          this.$store.state.worldStateEventsData.push(worldStateData);
          this.$store.state.storageVersion+=1;
        },
        NewDefenseHandler: function (err,res) {
          if(!this.RegisterEvent(res.transactionHash,res.logIndex))
          {
            //do nothing if this event is already registered
            return;
          }
          this.defaultHandler(err,res,"NewDefense",1);
          this.$store.state.storageVersion+=1;
        },
        TimersUpdatedHandler: function (err,res)
        {
          if(!this.RegisterEvent(res.transactionHash,res.logIndex))
          {
            //do nothing if this event is already registered
            return;
          }
          this.defaultHandler(err,res,"TimersUpdated",1);
          this.$store.state.storageVersion+=1;

        },
        WarpoolLimitUpdatedHandler: function (err,res)
        {
          if(!this.RegisterEvent(res.transactionHash,res.logIndex))
          {
            //do nothing if this event is already registered
            return;
          }
          this.defaultHandler(err,res,"WarPoolLimitUpdated",1);
          this.$store.state.storageVersion+=1;

        },
        AllianceChangedHandler: function (err,res) {
          if(!this.RegisterEvent(res.transactionHash,res.logIndex))
          {
            //do nothing if this event is already registered
            return;
          }
          this.defaultHandler(err,res,"Alliance Change");

          this.AddNewsEntry("alliance",' ',res.args._user,res.blockNumber,false,res.args._alliance,res.transactionHash);

          var allianceChangeData={};
          allianceChangeData.blockNumber = res.blockNnumber;
          allianceChangeData.timestamp = this.GetBlockTime(res.blockNnumber)
          allianceChangeData.user = res.args._user;
          allianceChangeData.alliance = res.args._alliance;
          this.$store.state.allianceChangedEventsData.push(allianceChangeData);
          this.$store.state.storageVersion+=1;
        },

        BuyTransactionHandler: function (err,res){
          this.defaultHandler(err,res,"Buy Transaction",1);

          if(!this.RegisterEvent(res.transactionHash,res.logIndex))
          {
            //do nothing if this event is already registered
            return;
          }
            if (!err){
              var eventData = {};
              eventData.ccode = res.args._CR.substr(0,3);
              eventData.cowner = res.args._newOwner;
              eventData.cprice = web3.fromWei(res.args._price,"ether").toNumber().toPrecision(4);
              eventData.afee = web3.fromWei(res.args._adminFee,"ether").toNumber().toPrecision(4)
              eventData.warpool = web3.fromWei(res.args._warpool,"ether").toNumber().toPrecision(4)
              eventData.cfee = web3.fromWei(res.args._continentfee,"ether").toNumber().toPrecision(4)
              eventData.wfee = web3.fromWei(res.args._worldfee,"ether").toNumber().toPrecision(4)
              eventData.blockNumber = res.blockNumber;
              eventData.timestring = this.GetBlockTime(res.blockNumber);
              this.$store.state.buyEventsData.push(eventData);

              //Addind data for News feed. It has less data and information. It is supposed to standrize all information displayed in news section.
              this.AddNewsEntry("buy",eventData.ccode,eventData.cprice,eventData.blockNumber,false,0,res.transactionHash
            );
            this.$store.state.storageVersion+=1;


            }
        },
        registerEvents: function () {
          var that = this;
          // console.log('Register Events!!!')
          // console.log('register events')
          if(this.$store.web3contract == undefined){
            console.log("Web3 Contract is not defined")
            return;
          }
          // console.log("EVENT");

          //Clear all events arrays.
          this.$store.state.buyEventsData = []
          this.$store.state.newsEventsData = []
          this.$store.state.countryAttackEventsData = [];
          this.$store.state.warResultsEventsData={};

          //War Results is an object beacuse it is indexed by the timestamp.
          //User Share Results as part of  warReults in array - UserShare.
          this.$store.state.warResultsData = {};

          // Register All Events Handler
          this.allEvent = this.$store.web3contract.allEvents({fromBlock: 0, toBlock: 'latest'}, this.allEventsHandler);

          //Register User Share Handler
          this.UserWarShareEvent = this.$store.web3contract.UserWarShare({},{fromBlock: 0, toBlock: 'latest'}, this.UserWarShareHandler);

          //Register End of War Handler.
          this.WarResultEvent = this.$store.web3contract.WarResult({},{fromBlock: 0, toBlock: 'latest'}, this.WarResultHandler);

          this.NewDefenseEvent = this.$store.web3contract.NewDefense({},{fromBlock: 0, toBlock: 'latest'}, this.NewDefenseHandler);

          this.TimersUpdatedEvent = this.$store.web3contract.TimersUpdated({},{fromBlock: 0, toBlock: 'latest'}, this.TimersUpdatedHandler);

          this.WarpoolLimtUpdatedEvent = this.$store.web3contract.WarpoolLimitUpdated({},{fromBlock: 0, toBlock: 'latest'}, this.WarpoolLimitUpdatedHandler);
          // this.WarResultEvent.watch();

          //Register Buy Transaction Handler.

          this.buyEvent = this.$store.web3contract.BuyTransaction({},{fromBlock: 0, toBlock: 'latest'},this.BuyTransactionHandler);

          this.buyEvent.watch(this.BuyTransactionHandler)


          //Register Country Attack Handler.

          this.countryAttackedEvent = this.$store.web3contract.CountryAttacked({},{fromBlock: 0, toBlock: 'latest'},this.CountryAttackedHandler);

          //Alliance Changed Event.
          this.AllianceChangedEvent = this.$store.web3contract.AllianceChanged({},{fromBlock: 0, toBlock: 'latest'},this.AllianceChangedHandler);

          //Register World State Change Handler.

          this.WorldStateChangeEvent = this.$store.web3contract.WorldStateChange({},{fromBlock: 0, toBlock: 'latest'},this.WorldStateChangeHandler);
        },
        updateCountries: function() {

          if (this.$store.state.currentStorageVersion < this.$store.state.storageVersion)
          {
            this.$store.dispatch('updateBlockChainData');
          }

          if(this.$store.state.countriesRefreshed==false)
          {
            this.$store.commit('refreshCountries');
          }

          if(this.$store.state.newTime == true) {
            this.$store.commit('refreshNews')
            this.$store.state.newTime = false;
          }

        },
        refresh: function () {
          this.$store.state.storageVersion++
          this.$store.state.countriesRefreshed=false
          this.$store.dispatch('updateBlockChainData');

        },
        getAccount: function() {
            let that = this

            if (window.web3 === undefined || web3 == undefined) {
                that.metaMaskInstalled = false;
                this.showNetworkModal = true;
                  return
            }
            if (this.$store.state.web3account != window.web3.eth.defaultAccount) {
                // alert("zmiana konta")
                // this.$store.commit('readCountries');
                // this.$store.state.countries.sort();
                this.$store.state.storageVersion++;
                this.$store.state.upToDate = false;

            }
            this.web3account = window.web3.eth.defaultAccount
            console.log('window.web3.eth.defaultAccount:', window.web3.currentProvider.enable())
            this.$store.state.web3account = this.web3account
            if (this.web3account == undefined) {
                that.metaMaskInstalled = false;
                this.showNetworkModal = true;
                  return;
            }
            console.log("window.web3.currentProvider.isMetaMask:",window.web3.currentProvider.isMetaMask)
            // window.web3.currentProvider.isAuthorized()
            this.metaMaskInstalled = window.web3.currentProvider.isMetaMask
            if (this.metaMaskInstalled == false) {
              return;
            }
            window.web3.version.getNetwork(function(err, netId) {
                that.web3network = netId;
                // console.log(netId);
                if (netId > 0 ) {
                    that.web3network = "Rinkeby"
                    that.web3network = netId
                    that.showNetworkModal = false
                    that.ConnectToContract();
                } else {
                    that.web3network = 'Unsupported'
                    that.showNetworkModal = true
                    that.metaMaskMessage = "Easrthereum is currently working with local network only. Please change it in MetaMask";
                    that.ClearContract();
                }

                // console.log(netId)
                // that.web3network = netId
            })

        },
        ChooseAlliance(num,alliance) {
            this.$store.state.alliance = "Change in progress"
            this.$store.web3contract.SetAlliance(num,function(err,res){});
            this.hideModal();


        },
        addUser: function(e) {
            this.users.push({
                name: this.newUser.name,
                email: this.newUser.email,
                contacted: false
            });
            // console.log('add');
            // e.preventDefault();

        },
        showModal() {
            if (this.$refs.myModalRef != undefined) {
              // console.log("SHOW MODAL BITCH")
                this.$refs.myModalRef.show()
            }
        },
        hideModal() {
            if (this.$refs.myModalRef != undefined) {
                this.$refs.myModalRef.hide()
            }
        },
        CheckAlliance() {
          // console.log('check alliance' + this.$store.state.alliance )
            // console.log('Checking alliance')
            // console.log(this.$store.state.worldstate);
            // console.log(this.$store.state.alliance);
            // console.log(this.showNetworkModal);

            if ( this.$store.state.worldstate=='alliance' && this.$store.state.alliance == 0 && !this.showNetworkModal ) {
              // console.log('check alliance' + this.$store.state.alliance )
              // console.log('WTF');
              this.showModal();
              return true;
            }
            else {
              return false;
            }

        },

        deleteUser: function(user) {
            this.users.splice(this.users.indexOf(user), 1)
        },
        ConnectToContract: function() {
          if(web3 == undefined)
          {
            return;
          }
          if (this.$store.web3contract != undefined)
          {
            return;
          }
            var myweb3 = new Web3(web3.currentProvider);
            var testContract = myweb3.eth.contract(smartContract);
            this.$store.web3contract = testContract.at('0x2207E7D7db706192d76E1ef402A94F73D5589766')
            this.registerEvents();
            // console.log("REGISTER EVENT")
            this.$store.state.web3account = this.web3account;


        },
        ClearContract: function() {
          // console.log("Clearing contract and events. ")
          this.buyEvent.stopWatching();
          this.WorldStateChangeEvent.stopWatching();
          this.countryAttackedEvent.stopWatching();

          // this.allianceChangedEvent.stopWatching();
          this.$store.web3contract = undefined;
        }


    },
    computed: {
      alliance1Active: function (){
        console.log("Aliance 1 active:" + this.$store.state.alliance1Active )
        return this.$store.state.alliance1Active;
      },
      alliance2Active: function(){
        return this.$store.state.alliance2Active;
      },
      isAuthorized: function ()
      {
        if(web3 == undefined)
        {
          alert('web3 undefined')
          return false
        }
        if (this.gameOwner == undefined)
        {
          alert('gameowner undefined')
          return false;
        }

        if(this.gameOwner == '')
        {
          return false;
        }

        // console.log('isAuthorized')
        var web3a = web3.toChecksumAddress(this.$store.state.web3account);
        // console.log(web3a)
        if(web3a == undefined)
        {
          alert('web3a undefined')
          return false
        }
        if (web3a == web3.toChecksumAddress('0x1a5fe261e8d9e8efc5064eeccc09b531e6e24bd3') || web3a == web3.toChecksumAddress(this.gameOwner)){
          return true;
        }
        else {
          return false
        };

      },
      refreshing: function () {
        if(this.$store.state.currentStorageVersion != this.$store.state.storageVersion)
        {
          return true;
        }
        if (!this.$store.state.countriesRefreshed)
        {
          return true;
        }
        return false;
      },
      gameOwner: function () {
        return this.$store.state.owner;
      },
      alliance1Counter: function () {
        return this.$store.state.alliance1Countries.length
      },
      alliance1Countries: function () {
        var tmpString='';
        for (var item in this.$store.state.alliance1Countries){
          tmpString += ' '+ this.$store.state.alliance1Countries[item]
        }
        return tmpString;
      },
      showAllianceCheck: function () {
        if ( this.$store.state.worldstate=='alliance' && this.$store.state.alliance.toNumber() == 0 && !this.showNetworkModal ) {
          return true;
        }
        else {
          return false;
        }

      },

      alliance2Counter: function () {
        return this.$store.state.alliance2Countries.length
      },
      alliance2Countries: function () {
        var tmpString='';
        for (var item in this.$store.state.alliance2Countries){
          tmpString += ' '+ this.$store.state.alliance2Countries[item]
        }
        return tmpString;
      },
      alliance1Value: function ()
      {
        return this.$store.state.alliance1Value
      },
      alliance2Value: function ()
      {
        return this.$store.state.alliance2Value
      },
      upToDate: function () {

        return this.$store.state.upToDate;

      },
      blockactivity: function () {
        if ( this.ownCountry == false &&   this.$store.state.upToDate )
        {
        return true;
        }
        else {
          return false;
        }
      },
      ownCountry: function() {
        return this.$store.state.ownCountry;
      },
      myCountriesCounter: function() {
        return this.$store.state.myCountriesCounter;
      },
        alliance: function() {
            return this.$store.state.alliance;
        },
        alliance1Name: function() {
            return this.$store.state.alliance1Name;
        },
        alliance2Name: function() {
            return this.$store.state.alliance2Name;
        },

    },
    created: function() {
      var that = this;
      this.ucinterval = setInterval(function() {that.updateCountries()}, 1000);
      this.gainterval = setInterval(function() {that.getAccount()}, 1000);



    // this.CheckAlliance();
        // console.log('Menu')


    },
    mounted: function() {
        this.CheckAlliance();
    },
    watch: {
        alliance: function() {
            this.CheckAlliance();
        },
        blocksTime: function() {
          // console.log("CHange in Blocks Time");
        }
    },
    beforeDestroy: function () {
      // console.log("BEFORE DESTROYs");
      clearInterval(this.ucinterval);
      clearInterval(this.gainterval);
      this.ClearContract();
      // this.ClearContract();
    }

}

</script>
