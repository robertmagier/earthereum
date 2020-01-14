<style lang="css" scoped >

.custom-file-label {
    text-align: left;
}

.countryEdit {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr  ;
    grid-gap: 0px 10px;
    padding: 30px;
    transition: all 0.5s;
    /* margin: 10px 10px; */
    background-color: rgba(6, 96, 140, 0.2);
    border-radius: 10px;
    /* margin: 0px 0px 15px 0px; */
    /* border-style:solid; */
    /* color:red; */
}

.countryFile {
    grid-column: 1/4;
    text-align: left;
    display: grid;
    grid-template-columns: 100px 120px 1fr  ;
    /* border-style:solid; */
    margin: 10px 10px;
}

.countryEdit label {
    /* border-style:solid; */
    vertical-align: middle;
    margin: 0px 10px;
    font-size: 14px;
    font-weight: 600;
    margin: 5px;
}

.countryDetails {
    background-color: rgba(255, 255, 255, 0);
}

.card.countriesmanagement {
    border-radius: 10px;
}

.card-body.countriesmanagement {
    background-color: rgba(255, 255, 255, 0.9);
    font-size: 16px;
    color: #000;
    border-radius: 10px;
}

.informationtable {
    border-radius: 10px;
    background-color: rgba(0, 34, 67, 0.9);
    width: 100%;
}

.informationtable td tr table {
    border-radius: 10px;
    /* background-color:rgba(0,34,67,0.9); */
    color: #fafafa;
    width: 100%;
}

.table {
    color: #fafafa;
    font-size: 12px;
    width: 100%;
}

.table td {
    height: 40px;
    /* margin:0px; */
    /* padding:10px; */
}

.table tr:hover {
    color: #F9BF15;
    cursor: pointer;
}

.table tbody {
    height: 100px;
    overflow-y: auto;
}

.table thead th {
    /* background-color: red; */
    background-color: rgba(0, 30, 60, 0);
    border-style: none;
    color: #fafafa;
}

.modal-body {
    background-color: red;
}

.noProgress {
  transition: 1s opacity;
  opacity:0;
}
.showProgress {
  transition: 1s opacity;
  opacity:1;
}
</style>

<template lang="html">

<div class="countriesholder">

    <b-modal centered ok-only ok-title="Cancel" ok-variant="info" hide-footer no-close-on-esc size="lg" id="modal1" ref="modal1" :title="actionUpdate ? 'Update Country' : 'Add New Country'">
        <b-form id="newCountry" @submit="ModifyCountry($event)">
            <div class="countryEdit">
                <div>
                    <label>Country Name</label>
                    <b-form-input required placeholder="Enter name" v-model="newCname" style="margin:10px;height:30px;" type="text"></b-form-input>
                </div>
                <div>
                    <label>Country Code</label>
                    <b-form-input :state="ccodeState" :disabled="actionUpdate" required placeholder="Enter code" v-model="newCcode" style="margin:10px;;height:30px;" type="text"></b-form-input>
                </div>
                <div>
                    <label>Parent Code</label>
                    <b-form-input :state="parentCodeState" :disabled="actionUpdate" required placeholder="Enter parent code" v-model="newParentCode" style="margin:10px;;height:30px;" type="text"></b-form-input>
                </div>
                <div>
                    <label>Price</label>
                    <b-form-input :disabled="actionUpdate" required placeholder="Enter price" v-model="newPrice" step="0.001" style="margin:10px;;height:30px;" type="number"></b-form-input>
                </div>
                <div>
                    <label>Capital City</label>
                    <b-form-input  placeholder="Enter capital city name" v-model="newCcap" style="margin:10px;;height:30px;" type="text"></b-form-input>
                </div>
                <div>
                    <label>Language</label>
                    <b-form-input  placeholder="Enter language" v-model="newClang" style="margin:10px;;height:30px;" type="text"></b-form-input>
                </div>
                <div>
                    <label>Currency</label>
                    <b-form-input  placeholder="Enter currency" v-model="newCcur" style="margin:10px;;height:30px;" type="text"></b-form-input>
                </div>
                <div>
                    <label>Population</label>
                    <b-form-input :state="cpopState" placeholder="Enter population" v-model="newCpop" style="margin:10px;;height:30px;" type="number" step="1"></b-form-input>
                </div>
                <div>
                    <label>President</label>
                    <b-form-input  placeholder="Enter preseident name" v-model="newCpres" style="margin:10px;;height:30px;" type="text"></b-form-input>
                </div>
                <div class="countryFile">
                    <label>Flag picture</label>
                    <div/>
                    <b-form-file  ref="file1" style="text-align:left;" v-model="flagfile" :state="Boolean(flagfile)" placeholder="Choose a file..."></b-form-file>
                </div>
                <div class="countryFile">
                    <label>Country picture</label>
                    <div/>
                    <b-form-file ref="file2" v-model="countryfile" :state="Boolean(countryfile)" placeholder="Choose a file..."></b-form-file>
                </div>

                <b-button type="submit" variant="primary">{{actionUpdate? 'Update':'Submit'}}</b-button>
                <b-button v-if="!actionUpdate" type="reset" variant="danger">Reset</b-button>
                <b-button v-if="actionUpdate" variant="danger" size="sm" @click="DeleteCountry($event)">Delete</b-button>


                <b-alert style="grid-column:1/4; margin:15px 0px; border-radius:10px" show  :variant="alertType" >
                    <b>{{CountryResult}}</b> <img src="static/wait.gif" v-bind:class="{showProgress:showProgress,noProgress:!showProgress}" style="margin:0px 10px;width:20px">
                </b-alert>
            </div>
        </b-form>

    </b-modal>


    <div style="align-items:center;display:grid;grid-template-columns:auto auto auto   1fr ;grid-template-rows:minmax(30px,60px);items-align:right">
        <b-pagination v-if="showTable" style=";margin:0px;" size="sm" :total-rows="totalRows" v-model="page" :per-page="perPage">
        </b-pagination>

        <b-form-input v-if="showTable" @key="Filtering" style="margin:20px;width:300px;height:30px;" v-model="filterField" type="text" placeholder="Filter countries"></b-form-input>
        <b-button @click="ShowNewCountry" variant="primary">New Country</b-button>

    </div>
    <b-table small v-model="shownItems" @filtered="onFiltered" striped hover :filter="filterField" :items="countriesTab" :fields="countryFields" :per-page="perPage" :current-page="page" :value="value" class="informationtable">
        <template slot="show_details" slot-scope="row">

            <b-button size="sm" @click="ShowUpdateCountry($event,row)" class="mr-2">
                {{ row.detailsShowing ? 'Hide' : 'Edit'}} Details
            </b-button>
        </template>

        <template slot="cpop" slot-scope="data">
            {{localNumber(data.value)}}
        </template>

        <template slot="row-details" slot-scope="row" class="countryDetails">
            <b-form id="newCountry" @submit="UpdateCountry($event,row)">

                <b-card class="CountriesManagement">
                    <!-- v-model="" -->
                    <div class="countryEdit">
                        <div>
                            <label>Country Name</label>
                            <b-form-input style="margin:10px;height:30px;" type="text" v-bind:value="row.item.cname" v-model="updateCname"></b-form-input>
                        </div>
                        <div>
                            <label>Country Code</label>
                            <b-form-input disabled style="margin:10px;;height:30px;" type="text" v-bind:value="row.item.ccode" min=2 max=2 required v-model="updateCcode"></b-form-input>
                        </div>
                        <div>
                            <label>Capital City</label>
                            <b-form-input style="margin:10px;;height:30px;" type="text" v-bind:value="row.item.ccap" v-model="updateCcap"></b-form-input>
                        </div>
                        <div>
                            <label>Language</label>
                            <b-form-input style="margin:10px;;height:30px;" type="text" v-bind:value="row.item.clang" v-model="updateClang"></b-form-input>
                        </div>
                        <div>
                            <label>Currency</label>
                            <b-form-input style="margin:10px;;height:30px;" type="text" v-bind:value="row.item.ccur" v-model="updateCcur"></b-form-input>
                        </div>
                        <div>
                            <label>Population</label>
                            <b-form-input style="margin:10px;;height:30px;" type="text" v-bind:value="row.item.cpop" v-model="updateCpop"></b-form-input>
                        </div>
                        <div>
                            <label>President</label>
                            <b-form-input style="margin:10px;;height:30px;" type="text" v-bind:value="row.item.cpres" v-model="updateCpres"></b-form-input>
                        </div>
                        <div class="countryFile">
                            <label>Flag picture</label>
                            <img :src="getFlagLink(row)" style="width:100px;margin:0px 5px"></img>
                            <b-form-file style="text-align:left;" v-model="updateflagfile" :state="Boolean(flagfile)" placeholder="Choose a file..."></b-form-file>

                        </div>
                        <div class="countryFile">
                            <label>Country picture</label>
                            <img :src="getCountryLink(row)" style="width:100px;margin:0px 5px;background-color:white"></img>
                            <b-form-file v-model="updatecountryfile" :state="Boolean(countryfile)" placeholder="Choose a file..."></b-form-file>
                        </div>

                    </div>
                    <div style="margin:0px 00px;display:grid;grid-gap:15px;">


                        <b-button type="submit" variant="primary">Update</b-button>
                        <div/>
                        <div/>
                        <b-button variant="danger" size="sm" @click="DeleteCountry(row)">Delete</b-button>
                        <b-alert style="grid-column:1/5;margin:15px 0px; border-radius:10px" :show="dismissCountDown" dismissible :variant="alertType" @dismissed="dismissCountDown=0" @dismiss-count-down="countDownChanged">
                            <b>{{CountryResult}}</b>
                        </b-alert>


                    </div>
                </b-card>
            </b-form>

        </template>
    </b-table>
</div>

</template>

<script>

import Vue from 'vue'
import bTable from 'bootstrap-vue/es/components/table/table';
Vue.component('b-table', bTable);
import bPagination from 'bootstrap-vue/es/components/pagination/pagination';
Vue.component('b-pagination', bPagination);
import bFormFile from 'bootstrap-vue/es/components/form-file/form-file';
Vue.component('b-form-file', bFormFile);
import vBModal from 'bootstrap-vue/es/directives/modal/modal';
Vue.directive('b-modal', vBModal);
import bForm from 'bootstrap-vue/es/components/form/form';
Vue.component('b-form', bForm);
import axios from 'axios'
import bAlert from 'bootstrap-vue/es/components/alert/alert';
Vue.component('b-alert', bAlert);

export default {
    name: 'CountriesManagement',
    data() {
        return {
            test: '',
            value: null,
            page: 0,
            showTable: true,
            filterField: null,
            dismissCountDown: 0,
            newCname: 'Canada',
            totalRows: 0,
            perPage: 10,
            newCcode: 'CA',
            newParentCode: 'CA',
            newPrice:0.005,
            newCcap: 'Ottawa',
            newClang: 'English',
            newCcur: 'CAD',
            newCpop: '36,000,000',
            newCpres: 'Justin Trudeau',
            alertType: 'primary',
            countryfile: null,
            CountryResult: 'Please provide all required details to add new country',
            updateCcode: '',
            updateCcap: '',
            updateClang: '',
            updateCcur: '',
            txfailed: false,
            updateCpop: '',
            updateCpres: '',
            updateCname: '',
            updatecountryfile: '',
            showProgress:false,
            updateCountries: 0,
            flagfile: null,
            updateflagfile: '',
            shownItems: {},
            actionUpdate:true,
            countryFields: ['cname', 'ccode', 'cowner', 'ccap', 'clang', 'ccur', 'cpop', 'cpres', 'cprice', 'show_details']

        }
    },
    methods: {

      localNumber: function(val) {
          return val.toLocaleString(undefined,{style:'decimal'})
      },
        ModifyCountry(evt) {
                evt.preventDefault();
                if (this.actionUpdate) {
                    this.UpdateCountry(evt)
                } else {
                    this.SubmitNewCountry(evt)
                }
            },
            ShowNewCountry() {
                this.CountryResult = 'Please provide all required details to add new country'
                this.actionUpdate = false
                this.$refs.modal1.show()
                this.newCname = ''
                this.newCcode = ''
                this.newParentCode = ''
                this.newCcap = ''
                this.newPrice = 0.005
                this.newCcur = ''
                this.newCpop = ''
                this.newCpres = ''
                this.newClang = ''
                this.countryfile = undefined
                this.flagfile = undefined

            },
            ShowUpdateCountry(evt, row) {
                this.actionUpdate = true
                this.newCname = row.item.cname
                this.newCcode = row.item.ccode
                // this.newCcode = row.item.ccode
                this.newCcap = row.item.ccap
                this.newCcur = row.item.ccur
                this.newCpop = row.item.cpop
                this.newCpres = row.item.cpres
                this.newClang = row.item.clang
                this.$refs.file1.reset()
                this.$refs.file2.reset()
                this.countryfile = undefined
                this.flagfile = undefined
                this.CountryResult = "Update or Delete this country"
                this.alertType = 'info'
                this.$refs.modal1.show()


            },
            countDownChanged(dismissCountDown) {
                this.dismissCountDown = dismissCountDown
                if ((dismissCountDown == 0) && (this.alertType == 'success')) {
                    this.$refs.modal1.hide();

                }
                if (dismissCountDown == 1)
                {
                  this.$store.commit('readCountries');
                }

            },
            showAlert(txt, level) {
              var that = this;
                this.dismissCountDown = 2;
                this.CountryResult = txt;
                if (level == 'ERR') {
                    this.alertType = 'danger'
                    that.$store.commit('readCountries')

                }
                if(level=='INFO')
                    {
                        this.alertType = 'primary'
                    }
                if(level=='SUCCESS')
                    {
                        this.alertType = 'success'
                        that.$store.commit('readCountries')

                    }
                if(level=='SUCCESSUPDATE')
                    {
                        this.alertType = 'success'
                        that.$store.commit('readCountries')
                        setTimeout(function()
                        {
                            that.alertType = 'primary'
                            that.CountryResult = "Update or Delete this country"

                       },3000)
                       that.$store.commit('readCountries')
                       return;

                    }
                if(level=='DELETED')
                    {
                        this.alertType = 'success'
                        setTimeout(function()
                        {

                          that.$refs.modal1.hide();
                       },3000)
                       that.$store.commit('readCountries')
                       return


                    }
                if(level=='DELETEDERR')
                    {
                        this.alertType = 'danger'
                        setTimeout(function()
                        {
                            that.alertType = 'success'
                            that.CountryResult = 'This means there was some error. Contract software development. You may also refresh page and try again'
                       },3000)
                       that.$store.commit('readCountries')

                       return;


                    }

                    setTimeout(function()
                    {
                      that.CountryResult = 'Please provide all required details to add new country.'
                      that.alertType = 'primary'
                   },5000)
            },
            getFlagLink(data) {
                var link;
                link = this.$config.API + '/getFlag?ccode=' + data.item.ccode + '&time=' + this.currentTime;
                // console.log(link)
                return link;
            },
            getCountryLink(data) {
                var link;
                link = this.$config.API + '/getCountryPicture?ccode=' + data.item.ccode + '&time=' + this.currentTime;
                // console.log(link)
                return link;
            },
            DeleteCountry(evt) {
                var that = this;
                that.CountryResult = "Sending transaction to the backend server...."
                evt.preventDefault();
                axios.get(this.$config.API + '/deleteCountry?ccode=' + this.newCcode).then(function(response) {
                    that.showAlert(response.data, 'DELETED')
                        // this.$store.state.countries.push({});
                        // this.$store.commit('readCountries');
                        // vm.$forceUpdate();
                    that.$store.state.storageVersion = that.$store.state.storageVersion +1
                    this.$store.state.countriesRefreshed=false
                    return


                }).catch(err => {
                    that.showAlert(err.response.data, 'DELETEDERR')
                        // this.$store.commit('readCountries');
                        // setTimeout(function() {
                        //     that.showTable = false;
                        //
                        // }, 2000)
                        // setTimeout(function() {
                        //     that.showTable = true;
                        //     this.$store.state.countries.push({});
                        //     // vm.$forceUpdate();
                        //
                        // }, 3000)
                })


            },
            UpdateCountry(evt) {

                // console.log(this.$refs.file1)
                // console.log(this.$refs.file1.selectedFile)
                    // alert(JSON.stringify(this.form));
                var form = new FormData();
                // form.cname = this.newCName;
                // form.ccode = this.newCcode;
                // form.ccap = this.newCcap;
                // form.clang = this.newClang;
                // form.ccur = this.newCcur;
                // form.cpop = this.newCpop;
                // form.cpres = this.newCpres;
                // form.cflag = this.flagfile;

                form.append('cname', this.newCname);
                form.append('ccode', this.newCcode);
                form.append('ccap', this.newCcap);
                form.append('clang', this.newClang);
                form.append('ccur', this.newCcur);
                form.append('cpop', this.newCpop);
                form.append('cpres', this.newCpres);
                // console.log("update:" + this.flagfile)
                if (this.$refs.file1.selectedFile != null) {
                    console.log('flagfile')
                    form.append('cflag', new Blob([this.$refs.file1.selectedFile], {
                        type: 'image/png'
                    }));
                }
                if (this.$refs.file2.selectedFile != null) {
                    form.append('cpic', new Blob([this.$refs.file2.selectedFile], {
                        type: 'image/png'
                    }));
                }

                var that = this;
                // POSTING TO BACKEND COUNTRY
                var apiAdr = this.$config.API + '/UpdateCountry'
                axios.post(apiAdr, form).then(function(res) {
                    that.showAlert(res.data, 'SUCCESSUPDATE')

                }).catch(err => {
                    that.showAlert(err.response.data, 'ERR')
                        // alert('ERROR:' + err.response.data);
                        // console.log(err.response.data);

                    // console.log('caught an error', err);
                });


            },
            SubmitNewCountry(evt) {
                // console.log(data);
                evt.preventDefault();
                // this.AddCountryToBackend()
                this.txfailed = false;
                // alert(JSON.stringify(this.form));
                var that = this;
                var web3c = this.$store.web3contract;
                // form.cname = this.newCName;
                // form.ccode = this.newCcode;
                // form.ccap = this.newCcap;
                // form.clang = this.newClang;
                // form.ccur = this.newCcur;
                // form.cpop = this.newCpop;
                // form.cpres = this.newCpres;
                // form.cflag = this.flagfile;
                // this.CountryResult = "Checking if Country exists in Blockchain"
                web3c.GetCountryData.call(this.newCcode,function(err,res){
                  var price = res[1].toNumber();
                  console.log(res)
                  console.log(err)
                  if(price > 0 )
                  {
                    that.alertType='danger'
                    that.CountryResult = 'Country Exist on Blockchain. Adding to database'
                    setTimeout(function(){that.AddCountryToBackend()},3000)
                  }
                  else {
                    that.alertType='primary'
                    that.CountryResult = 'Adding Country to Blockchain'
                    var price = web3.toWei(that.newPrice,"ether");
                    console.log('PRICE:' + price)
                    // function Mint(bytes3 _CR, uint _cType, bytes3 _parentCode, address _owner) public onlyOwner {
                    web3c.Mint(that.newCcode,1,that.newParentCode,0,price,function(err,res){
                      if (err)
                      {
                        that.CountryResult="Unexpected Error: " + err;
                        console.log(err)
                      }
                      else {
                        that.showProgress = true;
                        that.WaitForMintTransaction(res)
                      }
                    })
                  }
                })
              },
              VerifyCountry(num,seconds){
                if (num ==undefined)
                {
                  num = 0;
                }
                var web3c = this.$store.web3contract;
                var that = this;
                console.log(this.newCcode);
                web3c.GetCountryData.call(this.newCcode,function(err,res){
                  var price = res[1].toNumber();
                  console.log(res)
                  console.log(err)

                  if(price > 0 )
                  {
                    that.CountryResult = 'Country Addded to BlockChain. Adding to Backend'
                    that.AddCountryToBackend()
                  }
                  else {
                    console.log('Num:'+num)
                    if(num <5)
                    {
                      num++;

                      that.CountryResult = "Country is not visible on blockchain. Trying again ("+num+") in 5 seconds."
                      that.alertType = 'danger'
                      that.showProgress = true;
                      setTimeout(function(){that.VerifyCountry(num)},5000);
                    }
                    else {
                    that.CountryResult = "Country wasn't added to blockchain. Transaction failed."
                    console.log(err);
                    console.log(res);
                    that.showProgress = false;
                    that.txfailed = false;
                    that.alertType = 'danger'
                  }}
                })
              },
                WaitForMintTransaction(tx)
                {
                  var that = this;
                  if (this.showProgress == false)
                  {
                    this.CountryResult = 'Verifying Transaction'
                    setTimeout(function(){that.VerifyCountry()},3000);
                    return;
                  }
                  this.CountryResult="Waiting for transaction: " + tx;
                  var that = this;
                  setTimeout(function(){
                  web3.eth.getTransactionReceipt(tx,function(err,res){
                    if(err)
                    {
                    that.txfailed = true;
                    that.showProgess = false;
                    }
                    if(res !=undefined) {
                      that.showProgress = false;
                      that.txfailed = false;
                      console.log('Minting result')
                      console.log(res)
                    }

                  })
                  that.WaitForMintTransaction(tx)
                  },1000)
                },
                AddCountryToBackend()
                {
                var form = new FormData();
                form.append('cname', this.newCname);
                form.append('ccode', this.newCcode);
                form.append('ccap', this.newCcap);
                form.append('clang', this.newClang);
                form.append('ccur', this.newCcur);
                form.append('cpop', this.newCpop);
                form.append('cpres', this.newCpres);
                form.append('cflag', new Blob([this.flagfile], {
                    type: 'image/png'
                }));
                form.append('cpic', new Blob([this.countryfile], {
                    type: 'image/png'
                }));
                var that = this;
                // POSTING TO BACKEND COUNTRY
                var apiAdr = this.$config.API + '/NewCountry'
                axios.post(apiAdr, form).then(function(res) {
                    that.showAlert(res.data, 'SUCCESS')

                }).catch(err => {
                  var error = ''
                    if (err.response == undefined) {error = 'Undefined error. Contact Software developent team.' + err;}
                    else {error = err.response.data;}
                    that.showAlert(err.response.data, 'ERR')

                        // alert('ERROR:' + err.response.data);
                        // console.log(err.response.data);

                    // console.log('caught an error', err);
                });
                this.filterField = this.newCcode
                    // console.log(form)
            },
            rowClick(record, index) {

                // log(record);
            },
            Filtering: function() {},
            onFiltered(filteredItems) {
                // Trigger pagination to update the number of buttons/pages due to filtering
                this.totalRows = filteredItems.length
                this.page = 1
            }
    },
    computed: {
      ccodeState: function(val) {
        if( this.newCcode.length == 2) return true;
        if (this.newCcode.length == 3) return true;
        return false;

      },
      parentCodeState: function(val) {
        return this.newParentCode.length == 3 ? true: false
      },
      cpopState: function(val) {
        return this.newCpop >= 0 ? true: false
      },


        currentTime: function() {
            var time = Date.now()
            return time
        },
        countriesTab: function() {
          var tmpCountries=[];
            // console.log('countriesTab:')
            if (this.showTable == false) {
                return null;
            }
            for (var i = 0;i<this.$store.state.countries.length;i++)
            {
              if (this.$store.state.countries[i].cprice == 'Updating...')
              {
                // tmpCountries.push(this.$store.state.countries[i])

                // this.$store.state.countries[i].cprice ='No Blockchain data'
              }
              else {
                tmpCountries.push(this.$store.state.countries[i])
              }
            }
            // return this.$store.state.countries
            return tmpCountries;
        }

    },
    watch: {

    },
    created: function() {}

}

</script>
