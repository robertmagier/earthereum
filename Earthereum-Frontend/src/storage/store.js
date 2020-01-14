import Vue from 'vue';
import Vuex from 'vuex';
import vueResource from 'vue-resource'
import axios from 'axios'
import vueAxios from 'vue-axios'

Vue.use(Vuex);
Vue.use(vueResource);
Vue.use(axios)

function hex2a(hexx) {
    var hex = hexx.toString();//force conversion
    var str = '';
    for (var i = 2; i < hex.length; i += 2){
      if(parseInt(hex.substr(i, 2), 16) == 0) continue;
        str += String.fromCharCode(parseInt(hex.substr(i, 2), 16));
      }
    return str;
}

function sortFunction(a,b) {
  if (a.timestamp > b.timestamp ) return -1;
  if (a.timestamp < b.timestamp ) return 1;
  if (a.timestamp == b.timestamp ) return 0;
}

let toja = this;
export const store = new Vuex.Store({
  state: {
    warpool: 0,
    updateCountries:false,
    countries:[],
    worldstate:'',
    peacehours:1,
    alliance:null,
    peacedays:0,
    alliancehours:0,
    alliancedays:1,
    warhours:0,
    upToDate:false,
    wardays:1,
    timeLimit:0,
    timeStart:0,
    secondsLeft:0,
    timerRunning:0,
    warpoollimit:0,
    myCountriesCounter:0,
    myCountries:[],
    countDown:'',
    web3contract:{},
    web3account:'',
    alliance1Name:'Dragons',
    alliance2Name:'Bears',
    alliance1Countries:[],
    alliance2Countries:[],
    buyEventsData:[],
    newsEventsData:[],
    countryAttackEventsData:[],
    worldStateEventsData:[],
    warResultsEventsData:{},
    allianceChangedEventsData:[],
    storageVersion: 1,
    currentStorageVersion:0,
    alliance1Value:0,
    alliance2Value:0,
    alliance1Score:0,
    alliance2Score:0,
    alliance1Active: true,
    alliance2Active:true,
    eventsHash:[],
    countriesRefreshed:false,
    blocksTime:{},
    owner:'',
    newTime:false,
    drawNumber:0,
    ownCountry:false,
  },
  getters: {
    getAllianceName: (state) => (_num) =>
    {
      if (!_num){
        _num = state.alliance;
      }

      if (_num == 1) {
        return state.alliance1Name;
      }
      if (_num == 2) {
        return state.alliance2Name;
      }
      if (_num == 0) {
        return "Draw";
      }

      return "No Alliance";
    },
    getCountryList: state => {
      return state.countries;
    },
    CheckAlliance: state => {
      if (state.worldstate == 'alliance' && parseInt(state.alliance) == 0)
      {
        // console.log("Aktualny alians:" + state.alliance)
        return true;
      }
      else {
        return false;
      }
    },
    getCountry: (state) => (_ccode) => {
      return state.countries.find(country => country.ccode === _ccode)
        },
    CountDown: state => {
      var time = Math.round(new Date().getTime()/1000);
      return state.timeLimit - time;
    }

  },
  mutations: {
    UpdatePrice(state,payload) {
      // console.log('Update price: ' + payload.ccode + ' '+payload.price)
      for (var item in state.countries) {
        if (state.countries[item].ccode == payload.ccode) {

          var price = payload.price
          price = Math.ceil(price*10000)/10000
          state.countries[item].cprice = price;
          state.refreshCountries = false;
        }
      }
    },
    UpdateCountryType(state,payload) {

      for (var item in state.countries) {

        if (state.countries[item].ccode == payload.ccode) {
          state.countries[item].ctype = payload.ctype;
        }
      }
    },
    UpdateCountryAttacks(state,payload) {

      for (var item in state.countries) {

        if (state.countries[item].ccode == payload.ccode) {
          state.countries[item].attacks = payload.attacks;
        }
      }
    },
    UpdateOwner(state,payload) {

      for (var item in state.countries) {
        if (state.countries[item].ccode == payload.ccode) {
          state.countries[item].cowner = payload.owner;
        }
      }
    },
    UpdateCountryDefenses(state,payload) {

      for (var item in state.countries) {
        if (state.countries[item].ccode == payload.ccode) {
          state.countries[item].d1 = payload.d1;
          state.countries[item].d5 = payload.d5;
          state.countries[item].d15 = payload.d15;
        }
      }
    },

    UpdateAlliance(state,payload) {

      for (var item in state.countries) {
        if (state.countries[item].ccode == payload.ccode) {
          state.countries[item].alliance = payload.alliance;
          if(payload.ccode != undefined)
          {

          if(payload.alliance==1) {
            state.alliance1Countries.push(payload.ccode);


          }
          if(payload.alliance==2) {
            state.alliance2Countries.push(payload.ccode);

          }
        }
        }
      }
    },
    UpdateWarPool(state,value) {
      state.warpool = value;
    },
    UpdateUserAlliance(state,value) {
      state.alliance = value;
    },
    Peace(state) {
      state.worldstate='peace';
      // state.timeLimit = Math.round(new Date().getTime()/1000) + state.peacedays*24*60*60 + state.peacehours*60*60;
      // var time = Math.round(new Date().getTime() / 1000);
      // state.timeStart = Math.round(new Date().getTime()/1000);
      // state.alliance='peace';
      // state.secondsLeft = state.timeLimit - time;
    },
    Alliance(state) {
      state.worldstate='alliance';
      // state.timeLimit = Math.round(new Date().getTime()/1000) + state.alliancedays*24*60*60 + state.alliancehours*60*60;
      // var time = Math.round(new Date().getTime() / 1000);
      // state.secondsLeft = state.timeLimit - time;
      // state.timeStart = Math.round(new Date().getTime()/1000);
      // state.alliance ='free'
    },
    War(state) {
      state.worldstate='war';
      // state.timeLimit = Math.round(new Date().getTime()/1000) + state.wardays*24*60*60 + state.warhours*60*60;
      // var time = Math.round(new Date().getTime() / 1000);
      // state.secondsLeft = state.timeLimit - time;
      // state.timeStart = Math.round(new Date().getTime()/1000);
    },
    setWarPool(state, val) {
      state.warpool = val;
    },


    refreshNews(state) {
      // console.log("Refresh news")
      // console.log(state.blocksTime)
      // console.log(state.newsEventsData)
      if (state.newsEventsData)
      {
      for(var item in state.newsEventsData)
      {
        // console.log(state.newsEventsData[item].blockNumber)
        var ts = state.blocksTime[state.newsEventsData[item].blockNumber];
        state.newsEventsData[item].timestamp = ts;
        // console.log(ts)
        var timestring = new Date(ts*1000).toLocaleString()
        state.newsEventsData[item].timestring = timestring;
        // console.log("RobertMagier:" + timestring )

      }
      state.newsEventsData.sort(sortFunction);
      }

      if (state.buyEventsData)
      {
      for(var item in state.buyEventsData)
      {
        state.buyEventsData[item].timestamp = state.blocksTime[state.buyEventsData[item].blockNumber];

      }
      state.buyEventsData.sort(sortFunction);
    }
    if (state.countryAttackEventsData)
    {
      for(var item in state.countryAttackEventsData)
      {
        state.countryAttackEventsData[item].timestamp = state.blocksTime[state.countryAttackEventsData[item].blockNumber];
        state.countryAttackEventsData[item].timestring = new Date( state.blocksTime[state.countryAttackEventsData[item].blockNumber]*1000).toLocaleString();

      }
      state.countryAttackEventsData.sort(sortFunction);


      var tmpwarresults = {};
      for(item in state.warResultsEventsData)
      {
      tmpwarresults[item] = state.warResultsEventsData[item];
      }
      state.warResultsEventsData = null;
      state.warResultsEventsData  = tmpwarresults;

    }
  },

    refreshCountries(state) { //this function is only to shuffle countries so vue see there was some change it and will
                         //re-render map
        if(state.countries == undefined)
        {
          return;
        }
        state.countries.sort(function(a,b){
          return 0;})
    store.state.countriesRefreshed = true;


    },

    readCountries(state) {
      // var API = 'http://localhost:5000'
      var API = 'https://flask-backend-api.herokuapp.com'
      axios.get(API+'/getCountries').then(function(response){
        // state.countries = response.data
         // state.countries = Object.assign({},state.countries,response.data);
         state.countries = response.data.countries
         // console.log('ZOBAZMY KRAJE')
         // console.log(state.countries)
         for (var item in state.countries) {
         state.countries[item].cprice='Updating...'
         state.countries[item].cowner="Updating..."
         state.countries[item].ctype=1
         var countryData = state.countries[item];
       }

       store.dispatch('updateBlockChainData')
       state.updateCountries=true;

      });
      // setTimeout(store.commit('readCountries'),10000);
    },

  },
  actions :{
    updateBlockChainData(state) {

       store.state.alliance2Countries=[];
       store.state.alliance1Countries=[];

      // console.log("Update Countries");
      if ( this.web3contract == undefined) {
        // console.log("web3 contract is not defined in updateBlockchain")
        return false;
      }

      // function GetStateTime(uint _state) public  constant returns (uint _days, uint _hours)

      this.web3contract.GetStateTimers(function(err,res) {
        // console.log('!!!!!!!!!!!!!!!!!!!!!!!!!!! TIMERS !!!!!!!!!!!!!!!!')
        // console.log(res);
        store.state.peacedays = res[0].toNumber();
        store.state.peacehours = res[1].toNumber();
        store.state.alliancedays = res[2].toNumber();
        store.state.alliancehours = res[3].toNumber();
        store.state.wardays = res[4].toNumber();
        store.state.warhours = res[5].toNumber();
      });

      // function GetPhaseTimers() public constant returns (uint phase, uint start, uint end)
      this.web3contract.GetPhaseTimers(function(err,res) {
        var state = res[0].toNumber;
        // console.log("Get World State: " + res)
        if (state == 0 ) store.commit("Peace");
        if (state == 1 ) store.commit("Alliance");
        if (state == 2 ) store.commit("War");

        store.state.timeStart = res[1].toNumber();  //this variable is used to calculate percentage for peace counter.
        store.state.timeLimit = res[2].toNumber();

        // console.log('!!!!!!!!!!!! GetPhaseTimers !!!!!!!!!!')
        // console.log('Start:'+store.state.timeStart)
        // console.log('End:'+store.state.timeLimit)


      })

      this.web3contract.GetWarpoolLimit(function(err,res) {
        // console.log('!!!!!!!!!!!!!!!!!!!!!!!!!!! WarpoolLimit !!!!!!!!!!!!!!!!')
        store.state.warpoollimit = web3.fromWei(res.toNumber(),"ether");


      });
      this.web3contract.GetDrawNumber(function(err,res) {
        // console.log('!!!!!!!!!!!!!!!!!!!!!!!!!!! Draw Number !!!!!!!!!!!!!!!!')
        store.state.drawNumber =res.toNumber();


      });

      this.web3contract.GetAllianceValue(1,function(err,res){
        if (!err){
          store.state.alliance1Value = web3.fromWei(res.toNumber(),"ether");
        }
        else {
          // console.log(err)
        }
      })

      // console.log('GETTING OWNER')
      this.web3contract.owner(function(err,res){
        store.state.owner = res;
        // console.log('Owner')
        // console.log(res)
        // console.log(err)
        // console.log(err);
        // console.log(res);
      });

      this.web3contract.GetAllianceValue(2,function(err,res){
        if (!err){
          store.state.alliance2Value = web3.fromWei(res.toNumber(),"ether");
        }
        else {
          // console.log(err)
        }
      })
      this.web3contract.GetAllianceScore(1,function(err,res){
        if (!err){
          store.state.alliance1Score = web3.fromWei(res.toNumber(),"ether");
        }
        else {
          // console.log(err)
        }
      })
      this.web3contract.GetAllianceScore(2,function(err,res){
        if (!err){
          store.state.alliance2Score = web3.fromWei(res.toNumber(),"ether");
        }
        else {
          // console.log(err)
        }
      })


      this.web3contract.GetMyAlliance(function(err,res){
        if(!err)
        {

          store.commit("UpdateUserAlliance",res);
        }
        else {
          // console.log('GetMyAlliance')
          // console.log(err)
        }
      })

      this.web3contract.GetWorldState(function(err,res){
        if(!err)
        {
          // console.log("Get World State: " + res)
          if (res == 0 ) store.commit("Peace");
          if (res == 1 ) store.commit("Alliance");
          if (res == 2 ) store.commit("War");
        }
        else {
          // console.log(err)
        }
      })

      this.web3contract.UserCountries(0,function(err,res){
        if  (!err)
        {
        // console.log("How many countries I have ? Answer:"+res.length);
        store.state.myCountriesCounter = res.length;
        store.state.myCountries = res;
        store.state.upToDate = true;
        }
        else {

            // console.log(err);

        }

      // store.commit("UpdateMyCountries",web3.fromWei(res.toNumber(),"ether"));
      })
      this.web3contract.GetAllowedAlliances(function(err,res){
        // console.log("GetAllowedAlliances")
        if(!err)
        {
        store.state.alliance1Active = res[0];
        store.state.alliance2Active = res[1];
        console.log(res[0])
        console.log(res[1])
        }
      })
      this.web3contract.OwnCountry(0,function(err,res){
        if  (!err)
        {
          // console.log("Own Country")
          // console.log(res)
          if(res > 0)
          store.state.ownCountry = true;
          else store.state.ownCountry = false;

          // console.log(store.state.ownCountry)
        // console.log("How many countries I have ? Answer:"+res.length);
        // store.state.myCountriesCounter = res.length;
        // store.state.myCountries = res;
        // store.state.upToDate = true;
        }
        else {

            // console.log(err);

        }

      // store.commit("UpdateMyCountries",web3.fromWei(res.toNumber(),"ether"));
      })

      //Get contract balance to publish it as a warpool value.
      this.web3contract.GetBalance(function(err,res){
      store.commit("UpdateWarPool",web3.fromWei(res.toNumber(),"ether"));
      })

      //****************** Going into loop for every country.
      for (var item in store.state.countries) {
      var countryData = store.state.countries[item];



      this.web3contract.GetCountryData(countryData.ccode,function(err,res){
        var code = hex2a(res[0])
        store.commit("UpdateCountryType",{ccode:code,ctype:res[3].toNumber()})
        // console.log("DADADADDAD");
        // console.log(res)
        store.commit("UpdateCountryAttacks",{ccode:code,attacks:res[5].toNumber()})
        store.commit("UpdatePrice",{ccode:code,price:web3.fromWei(res[1].toNumber(),"ether")})
          store.commit("UpdateOwner",{ccode:code,owner:res[2]});
          // console.log('Country Owner ' + code + '  ' + res[2])
          store.commit("UpdateAlliance",{ccode:code,alliance:res[4]});

        // console.log("Price: " + web3.fromWei(res[1].toNumber(),"ether") )

        store.state.countriesRefreshed = false;

      })

      this.web3contract.GetCountryDefenses(countryData.ccode,function(err,res){
        var code = hex2a(res[0])

        if(err)
        {
          // console.log(err)
          store.commit("UpdateCountryDefenses",{ccode:code,d1:undefined,d5:undefined,d15:undefined})
          return
        }
        store.commit("UpdateCountryDefenses",{ccode:code,d1:res[1],d5:res[2],d15:res[3]})
        // console.log(res);
      })
    }
    store.state.currentStorageVersion = store.state.storageVersion;

    }

  }
});
