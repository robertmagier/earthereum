var Earthereum = artifacts.require("./Earthereum.sol");
expect = require("chai").expect;




contract("Test Earthereum contract",function (accounts){

  describe("Deploy Earthereum smart contract",function(accounts){
    it("should catch Earthereum smart contract address",function(){
      return Earthereum.new().then(function(instance){
        earthereumContract = instance;

      })
    })
  })
  describe ("Add new countries one continent and world instance.Basic configuration.",function(){

    it("should be possible to check Contract Owner Balance",function(){
      originalBalance = web3.eth.getBalance(accounts[0])
        // console.log('Balance:' + web3.fromWei(contractBalance,"ether"));
        expect(originalBalance.toNumber()).to.be.above(0);
  })
    it("should add United States (US) country to the list of countries",function(){
      return earthereumContract.Mint("US",1,"NA",0).then(function(res){
        expect(res).to.not.to.be.an("error");
      })
    })
    it("should add Mexico(MX) country to the list of countries",function(){
      return earthereumContract.Mint("MX",1,"NA",0).then(function(res){
        expect(res).to.not.to.be.an("error");
      })
    })
    it("should add North America(NA) continent to the list of countries",function(){
      return earthereumContract.Mint("NA",2,"WR",0).then(function(res){
        expect(res).to.not.to.be.an("error");
      })
    })
    it("should add World(WR) instance to the list of countries",function(){
      return earthereumContract.Mint("WR",3,"",0).then(function(res){
        expect(res).to.not.to.be.an("error");
      })
    })
  })

  describe ("Check inital prices of add countries, continent and world",function(){
    it("United States (US) price should be more than zero",function(){
      return earthereumContract.GetCountryPrice("US").then(function(res){
        expect(res.toNumber()).to.be.above(0);
        USprice = res.toNumber();
      })
    })
    it("Mexico (MX) price should be more than zero",function(){
      return earthereumContract.GetCountryPrice("MX").then(function(res){
        expect(res.toNumber()).to.be.above(0);
        MXprice = res.toNumber();

      })
    })
    it("North America (NA) price should be more than zero",function(){
      return earthereumContract.GetCountryPrice("NA").then(function(res){
        expect(res.toNumber()).to.be.above(0);
        NAprice = res.toNumber();

      })
    })
    it("World Price (WR) should be more than zero. ",function(){
      return earthereumContract.GetCountryPrice("WR").then(function(res){
        expect(res.toNumber()).to.be.above(0);
        WRprice = res.toNumber();

      })
    })
  });


  describe ("Buy countries, continent and world by four different parties and check prices",function(){

    it("should be possible to buy check Contract Owner Balance",function(){
      contractBalance = web3.eth.getBalance(accounts[0]);
      beforeBuyBalance = contractBalance;
        console.log('Balance:' +web3.fromWei(contractBalance,"ether"));
        expect(contractBalance.toNumber()).to.be.below(originalBalance.toNumber());




  })
    it("should be possible to buy US",function(){
      return earthereumContract.BuyCountry("US",{"from":accounts[1],"value":10000000000000000000}).then(function(res){
        expect(res).to.not.be.an("error");

      })
  })
    it("US price should be 15% higher than before",function(){
      return earthereumContract.GetCountryPrice("US").then(function(res){
        expect(res.toNumber()).to.be.equal(USprice*1.15);

      })
  })
    it("US owner should be the one who just bought it",function(){
      return earthereumContract.GetCountryOwner("US").then(function(res){
        expect(res).to.be.equal(accounts[1]);

      })
  })
    it("should be possible to buy MX",function(){
      return earthereumContract.BuyCountry("MX",{"from":accounts[2],"value":10000000000000000000}).then(function(res){
        expect(res).to.not.be.an("error");

      })
  })
    it("MX price should be 15% higher than before",function(){
      return earthereumContract.GetCountryPrice("MX").then(function(res){
        expect(res.toNumber()).to.be.equal(MXprice*1.15);

      })
  })
    it("should be possible to buy North America (NA)",function(){
      return earthereumContract.BuyCountry("NA",{"from":accounts[3],"value":web3.toWei(10,"Ether")}).then(function(res){
        expect(res).to.not.be.an("error");

      })
  })
    it("NA price should be 15% higher than before",function(){
      return earthereumContract.GetCountryPrice("NA").then(function(res){
        expect(res.toNumber()).to.be.equal(NAprice*1.15);

      })
  })
    it("should be possible to buy WR",function(){
      return earthereumContract.BuyCountry("WR",{"from":accounts[4],"value":10000000000000000000}).then(function(res){
        expect(res).to.not.be.an("error");

      })
  })
    it("WR price should be 15% higher than before",function(){
      return earthereumContract.GetCountryPrice("WR").then(function(res){
        expect(res.toNumber()).to.be.equal(WRprice*1.15);

      })
  })

    it("Contract balance (warpool) should include fees for all 4 warpool buying transactions. This is 2% for each transaction ",function(){
      return earthereumContract.GetBalance({"from":accounts[0]}).then(function(res){
        // warpoolValue = (USprice*0.02).add((MXprice*0.02)).add((NAprice*0.02)).add((WRprice*0.02));
        expect(res.toNumber()).to.be.equal(web3.toBigNumber(web3.toWei(0.8,"ether")).toNumber());
      })
  })

  it("Owner Balance should include fees from Buying Transactions. 4 x 3% from Transaction fee. ",function(){
    contractBalance = web3.eth.getBalance(accounts[0]);

      // console.log('Balance:' +web3.fromWei(contractBalance,"ether"));
      expectedBalance = beforeBuyBalance.toNumber()+web3.toBigNumber(web3.toWei(40-0.8,"ether")).toNumber();
      expect(contractBalance.toNumber()).to.be.equal(expectedBalance);

})


});
describe ("Buy Country and see if Admin get's it's fee. ",function(){
  let originalPrice;

  it("Get Admin's Balance",function(){
    // beforeBuylBalance2 = web3.toBigNumber(web3.eth.getBalance(accounts[0])).toNumber();
    contractBalance = web3.eth.getBalance(accounts[0]);
    beforeBuyBalance2 = contractBalance
    earthereumContract.GetCountryPrice("MX").then(function(res){
      originalPrice2 = res.toNumber();
    })

    expect(originalBalance.toNumber()).to.be.above(0);

})

it("should be possible to buy MX",function(){
  return earthereumContract.BuyCountry("MX",{"from":accounts[1],"value":15000000000000000000}).then(function(res){
    expect(res).to.not.be.an("error");

  })
})

it("Owner Balance should include fee for buying Mexico",function(){
  contractBalance = web3.eth.getBalance(accounts[0]);

    // console.log('Balance:' +web3.fromWei(contractBalance,"ether"));
    expectedBalance = parseInt(beforeBuyBalance2)+parseInt(originalPrice2*0.03);
    expect(contractBalance.toNumber()).to.be.equal(expectedBalance);

})

});


describe ("Attack country and see if price is being reduced",function(){

  it("Choose alliance 1 for US owner.",function(){
    return earthereumContract.SetAlliance(1,{"from":accounts[1]}).then(function(res){
      expect(res).to.not.be.an("error");

    })
  })
  it("should be possible to buy MX",function(){
    return earthereumContract.BuyCountry("MX",{"from":accounts[2],"value":15000000000000000000}).then(function(res){
      expect(res).to.not.be.an("error");

    })
  })

  it("should be possible to attack MX for 25%",function(){
    return earthereumContract.AttackCountry("MX",1,{"from":accounts[1],"value":30000000000000000000}).then(function(res){
      // console.log(res)
      expect(res).to.not.be.an("error");

    })

  })

});

});
