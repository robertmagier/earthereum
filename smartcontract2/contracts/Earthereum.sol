pragma solidity ^0.4.18;



import "./SafeMath.sol";
import "./Owned.sol";

contract Earthereum is Owned {
  using SafeMath
  for uint256;
  using SafeMath
  for uint;



  struct CountryS {
    /* bytes3 code; */
    uint price;
    uint attacks; //value for which country was attacked in one war phase.
    //it is in percent, can't be bigger than 25% and
    // defended attacks is not counted.

    address owner;
    uint cType; //1 - country, 2- continent,3 - world
    bytes3 parentCode; //continents code or the world code if this is a continent.
    //Defense costs 1, 5 or 15 permill of the country price and it stays untill used.
    mapping(uint => bool) defenses;

  }

  struct CountryData {
    bytes3 ccode;
    uint price;
    uint attacks;
    address owner;
    uint cType;
    bytes3 parentCode;
    uint alliance;

  }

  // ************************ Evnets *****************/
  //** BuyTransaction triggered when someone buys a country.
  event BuyTransaction(string _CR, address _newOwner, uint _price, uint _warpool, uint _adminFee, uint _continentfee, uint _worldfee);
  //** Triggered when world change it's state. From peace to alliance to war.
  event WorldStateChange(uint _newstate);
  //*** Triggered when somebody set alliance.
  event AllianceChanged(address _user, uint _alliance);

  //** Triggered when somebody attacked a country.
  event CountryAttacked(address _attacker, bytes3 _CR, uint _attackType, uint _attackvalue, bool defended);

  //Event triggered when somebody bought a defense.
  event NewDefense();
  event TimersUpdated();
  event WarpoolLimitUpdated();


  /* event Attack(bytes3, uint); */
  string public name = "Earthereum";
  uint worldstate = 0; //0 - peace  1 - choose alliance 2-war
  uint warpoollimit = 10000;
  uint drawNumber = 0;

  uint[] timersHours;
  uint[] timersDays;

  uint phaseStarts = 0;
  uint phaseEnds = 3600; //time when current phase ends.

  //Initial Country Price in Wei. 1 Ether = 1000000000000000000 Wei.
  //  uint initialPrice = 5000000000000000;
  uint initialPrice = 5000000000000000;
  uint initialPriceContinent = 150000000000000000;
  uint initialPriceWorld = 250000000000000000;
  //fees values for attacks and buying transactions

  uint adminPer = 3;
  uint warPoolPer = 2;
  uint continentPer = 1;
  uint worldPer = 1;




  //Array of 2 letters country symbols.
  bytes3[] countries;
  // Mapping from token symbol to owner address
  mapping(bytes3 => CountryS) private countriesData;

  //Map user address to Aliance number 2.
  mapping(address => uint) private usersAlliance;

  //Map owner to the list of his countries
  mapping(address => bytes3[]) private userCountries;
  //Map country to index in the list of userCountries;
  mapping(bytes3 => uint) private countryUserIndex;
  //Map amount of countries owned by user. Only countries !! Not continents or world.
  mapping(address => uint) private userCountryCounter;
  //Amount of ether spend for attacks in this war.
  mapping(address => uint) private usersAttacks;
  //List of attacking  users in this war phase.
  //Used together with usersAttacks it is possible to calculate amount of money spend for all attacks.
  mapping(address => uint) private usersDefenses;
  address[] contributors;

  uint public alliance1Attacks;
  uint public alliance2Attacks;

  uint private totalDefense;

  function GetDrawNumber() public constant returns (uint) {
    return drawNumber;
  }

  function GetCountryData(bytes3 _CR) public constant returns(bytes3 _CRout, uint _price, address _owner, uint _cType,  uint _alliance, uint _attacks) {
    require(countriesData[_CR].price > 0);
    uint alliance;
    alliance = usersAlliance[countriesData[_CR].owner];
    return (
      _CR,
      countriesData[_CR].price,
      countriesData[_CR].owner,
      countriesData[_CR].cType,
      alliance,
      countriesData[_CR].attacks
    );
  }

function  UpdateWarpoolLimit (uint _limit) public onlyOwner
{
  warpoollimit = _limit;
  WarpoolLimitUpdated();
}

function GetWarpoolLimit() public constant returns (uint)
{
  return warpoollimit;
}

function CalculatePeaceEnd () constant returns  (uint){
  uint poolPer;
  uint timePer;
  if (now > phaseEnds || phaseStarts > now) //set timePer to 100 in case we are out of time range for Peace.
  {
    timePer = 100;
  }
  else {
    uint timeRange = phaseEnds - phaseStarts;
    uint timeLapsed = now - phaseStarts;
    timePer = (timeLapsed * 100 / timeRange);

  }

  if (warpoollimit == 0 || this.balance > warpoollimit)
  {
    poolPer = 100;
  }
  else {
    poolPer = ((this.balance*100) / warpoollimit);
  }

  if(poolPer < timePer) { //min function at work ;)
    return poolPer;
  }
  else {
    return timePer;
  }


}

function UpdatePhaseTime(uint _state) internal {
  phaseStarts = now;
  /* phaseEnds = phaseStarts + timersDays[_state]*24*60*60 + timersHours[_state]*60*60; */
  //testing only here one day == one hour and one hour == minute.
  phaseEnds = phaseStarts + timersDays[_state]*60*60 + timersHours[_state]*60;
}


// This function change state of the game whoever call it. First it checks if game is ready to Switch and if so it is going to switch.
function ProtectedStateSwitch() public returns (bool switched)
{
  bool ready;
  uint left;
  (ready,left) = ReadyToSwitch();
  if (ready)
  {
    if(worldstate==0)
    {
      return SetWorldState(1);
    }
    if(worldstate==1)
    {
      return SetWorldState(2);
    }
    if(worldstate==2)
    {
     return  SetWorldState(0);
    }
  }
}
//Function check if it is time to switch phases. Returns true when owner should run SwitchState function.
//This is constant function so there is no cost to run it. SwitchState function uses gas.
function ReadyToSwitch () public constant returns (bool ready,uint valueleft)
{
 if(worldstate == 0 )
 {
   if ( CalculatePeaceEnd() == 100)
   {
     return (true,0);
   }
   else
   {
     return (false,100-CalculatePeaceEnd());
   }
 }

 if(worldstate == 1)
 {
   if (now > phaseEnds){
     return (true,0);
   }
   else {
     return (false,phaseEnds-now);
   }
 }

 if(worldstate == 2)
 {
   if (now > phaseEnds){
       return (true,0);
   }
   else {
     return (false,phaseEnds-now);
   }
 }
}
//This function checks if you condition to switch to next phase was met. If so  it is going to next state.
//In case there is draw in war then Finish War function will extend phase by one hour and state is not going to be
// changed. This function doesn't change state. It only checks if there is a condition and initiate action.
function SwitchState () public onlyOwner () returns (bool)
{
  //If worldstate is different than 0,1 or 2 it means something went really wrong in smart contract.
  // There are only three stages 0 - peace, 1 - alliance, 2 - war.
  assert (worldstate == 0 || worldstate == 1 || worldstate == 2);


  if ( worldstate == 0 ) //peace. we check time limit and warpool limit.
  {
    uint peacerange;
    peacerange = CalculatePeaceEnd();
    assert ( peacerange >= 0 && peacerange <= 100); //it has to be within 0 to 100 limit. In other case there is a problem with implementation.
    if (peacerange == 100) {
      SetWorldState(1);
      return true;
    } else {
      return false;
    }
  }
  if ( worldstate == 1 ) //peace. we check time limit and warpool limit.
  {
    if (now >= phaseEnds) {
      SetWorldState(2);
      return true;
    }else
    {
      return false;
    }
  }
  if ( worldstate == 2 ) //peace. we check time limit and warpool limit.
  {
    if (now >= phaseEnds) {
      SetWorldState(0);
      return true;
    }
    else {
      return false;
    }
  }

}

  function ownedSetWorldState (uint _state) public onlyOwner returns(bool)
  {
    return SetWorldState(_state);
  }
  //testing only function used to simulate phases
  function SetWorldState(uint _state) internal  returns(bool) {

    require(_state == 0 || _state == 1 || _state==2);
    bool result;
    if (worldstate == 2 && _state == 0) //end of war going to peace
    {
      result = FinishWar();
      if (!result && drawNumber < 8) { //there was a draw. Exten War by one hour from now.
        phaseEnds = now + 3600;
        drawNumber += 1;
        return false;
        }
        else{

          worldstate = _state;
          WorldStateChange(_state);
          UpdatePhaseTime(_state);
          CleanAfterWar();
          return true;
        }

    }

    if (worldstate == 0 && _state == 1)
    {
      worldstate = _state;
      WorldStateChange(_state);
      UpdatePhaseTime(_state);

      return true;
    }

    if(worldstate == 1 && _state == 2 )
    {
      worldstate = _state;
      ForceAlliance();
      WorldStateChange(_state);
      UpdatePhaseTime(_state);

      return true;
    }

    worldstate = _state;
    WorldStateChange(_state);
    UpdatePhaseTime(_state);
    return true;

   /* throw; */
  }


  function GetWorldState() public constant returns(uint) {

    return worldstate;
  }


  //If current time is > phaseEnd then Change to the next phase and calculate new time limit for the phase.
  function EndPhase() private onlyOwner returns(uint) {
    if (now >= phaseEnds) {
      if (worldstate == 0) {

      }
      if (worldstate == 1) {

      }
      if (worldstate == 2) {
        if (FinishWar() == false) {
          //war can't be ended because there is a draw and we extend it.
          ExtendPhase(3600);
          return phaseEnds;
        }
      }

      worldstate++;
      if (worldstate == 3) { //there are only three states. 0, 1 and 2.
        worldstate = 0;
      }
      phaseEnds += (timersDays[worldstate]*24*60*60 + timersHours[worldstate]*60*60 );

    }

    return phaseEnds;

  }
  //Extend current phase(war,alliance,peace) by specified amount of time and returns new time limit
  function ExtendPhase(uint _amount) private onlyOwner returns(uint) {

    phaseEnds += _amount;
    return phaseEnds;

  }

  function GetUserCountries(address _owner) public constant returns(bytes3[]) {
    require(_owner != 0);
    return userCountries[_owner];
  }

  function GetCountryUserIndex(bytes3 _CR) public constant returns(uint) {
    require(countriesData[_CR].price > 0);
    return countryUserIndex[_CR];
  }

  //create new Country Symbol and assign it to contract owner.
  //define initial price to
  function Mint(bytes3 _CR, uint _cType, bytes3 _parentCode, address _owner) public {
    require(countriesData[_CR].price == 0);
    var country = CountryS(0, 0, 0, 0, 0);

    //if _owner is zero it means that country is owned by the contract owner.
    if (_owner == 0) {
      _owner = owner;
    }

    country.attacks = 0;
    //   country.code=_CR;
    country.cType = _cType;

    if (_cType == 1) {
      country.price = initialPrice;

    }
    if (_cType == 2) {
      country.price = initialPriceContinent;

    }
    if (_cType == 3) {
      country.price = initialPriceWorld;

    }

    country.parentCode = _parentCode;
    countriesData[_CR] = country;
    countries.push(_CR); //used only to get county and list of countries for frontend.

    AddUserCountry(_CR, _owner);

    //   tokenPrice[_CR] = 150000000000000000; //0.15 ETHs
  }

  function Earthereum() public {
    timersDays.push(0); //peace
    timersDays.push(0); //alliance
    timersDays.push(0); //war

    timersHours.push(1); //peace
    timersHours.push(1); //alliance
    timersHours.push(1); //war

    //Set state as peace, phase Start as now and define end of Peace as one hour from now.
    phaseStarts = now;
    phaseEnds = timersDays[0]*24*3600 + timersHours[0] * 3600 + phaseStarts;
    worldstate = 0;



    //for testing only.
    /* Mint('US', 1, "NA", 0x14723a09acff6d2a60dcdf7aa4aff308fddc160c); */
    /* Mint('MX', 1, "NA", 0x14723a09acff6d2a60dcdf7aa4aff308fddc160c);
    Mint('NA', 2, "WR", 0x14723a09acff6d2a60dcdf7aa4aff308fddc160c);
    Mint('WR', 3, "", 0x14723a09acff6d2a60dcdf7aa4aff308fddc160c); */
  }

  function MintDefaultCountries() public onlyOwner {
    Mint('CAS', 2, 'WR', 0); //Asia
    Mint('CSA', 2, 'WR', 0); //South America
    Mint('CNA', 2, 'WR', 0); //North America
    Mint('CCA', 2, 'WR', 0); //Central America
    Mint('CZL', 2, 'WR', 0); //Zealandia
    Mint('CAF', 2, 'WR', 0); //Africa
    Mint('CEU', 2, 'WR', 0); //Europe
    Mint('CWR', 3, '', 0); //World
    Mint('CL', 1, 'CSA', 0); //Chile
    Mint('AR', 1, 'CSA', 0); //Argentina
    Mint('GY', 1, 'CSA', 0); //Guyana
    Mint('BO', 1, 'CSA', 0); //Bolivia
    Mint('TH', 1, 'CAS', 0); //Thailand
    Mint('MY', 1, 'CAS', 0); //Malaysia
    Mint('VN', 1, 'CAS', 0); //Vietnam
    Mint('ID', 1, 'CAS', 0); //Indonesia
    Mint('LA', 1, 'CAS', 0); //Laos
    Mint('NZ', 1, 'CZL', 0); //New Zealand
    Mint('FJ', 1, 'CAS', 0); //Fiji
    Mint('ZA', 1, 'CAF', 0); //Souh Africa
    Mint('MG', 1, 'CAF', 0); //Madagascar
    Mint('TZ', 1, 'CAF', 0); //Tanzania
    Mint('KE', 1, 'CAF', 0); //Kenya
    Mint('CI', 1, 'CAF', 0); //Ivory Coast
    Mint('CZ', 1, 'CEU', 0); //Czech Republic
    Mint('NO', 1, 'CEU', 0); //Norway
    Mint('CH', 1, 'CEU', 0); //Switzerland
    Mint('SE', 1, 'CEU', 0); //Sweden
    Mint('LU', 1, 'CEU', 0); //Luxembourg
    Mint('CR', 1, 'CCA', 0); //Costa Rica
    Mint('BZ', 1, 'CCA', 0); //Belize
    Mint('PA', 1, 'CCA', 0); //Panama
    Mint('SV', 1, 'CCA', 0); //El Salvador
    Mint('MX', 1, 'CNA', 0); //Mexico

  }
  //get amount of defined countries
  function GetCountriesCount() public constant returns(uint256) {
    return countries.length;
  }

  function bytes3ToStr(bytes3 _bytes3) public constant returns(string) {

    // string memory str = string(_bytes32);
    // TypeError: Explicit type conversion not allowed from "bytes32" to "string storage pointer"
    // thus we should fist convert bytes32 to bytes (to dynamically-sized byte array)

    bytes memory bytesArray = new bytes(3);
    for (uint256 i; i < 3; i++) {
      bytesArray[i] = _bytes3[i];
    }
    return string(bytesArray);
  }
  //Get a price of a country in WEI or throw if country doesn't exist.
  function GetCountryPrice(bytes3 _CR) public constant returns(uint price, string country) {
    require(countriesData[_CR].price != 0);
    return (countriesData[_CR].price, bytes3ToStr(_CR));
  }

  function GetCountries() public constant returns(bytes3[]) //return list of countries symbols.
  {
    return countries;
  }


  function GetCountryOwner(bytes3 _CR) public constant returns(address, string) {
    require(countriesData[_CR].owner != 0);
    return (countriesData[_CR].owner, bytes3ToStr(_CR));
  }

  function GetBalance() public constant returns(uint) {
    return this.balance;
  }

  function WithdrawMoney() public onlyOwner
  //send all money to the contract owner. This means there will be no money for warpool.
  //I guess this function should be deleted so the game can be trusted ;)
  {
    owner.send(this.balance);
  }
  //Buy country change it's price and send ether to previous owner and fee to contract owner
  function BuyCountry(bytes3 _CR) public payable returns(bool) {

    require(msg.sender != owner); //contract Owner can't buy a country.
    require(countriesData[_CR].price > 0); //you can buy country only if country.price is > 0
    require(countriesData[_CR].owner != msg.sender); // you can't buy country from yourself.
    require(msg.value >= countriesData[_CR].price); //you can buy only if you send enough Ether

    uint continentFee = 0;
    uint worldFee = 0;
    uint oldPrice = countriesData[_CR].price;
    address oldOwner = countriesData[_CR].owner;

    //Calculate Administrator Fee and send it to the owner.

    uint adminFee = oldPrice.percent(adminPer); //calculate fee for admin.
    owner.send(adminFee);

    //Calculate warpool Fee and keep it here.

    uint warPoolFee = oldPrice.percent(warPoolPer);

    continentFee = oldPrice.percent(continentPer);
    worldFee = oldPrice.percent(worldPer);

    if ((countriesData[_CR].cType) == 1 && (countriesData[countriesData[_CR].parentCode].owner != 0)) {
      countriesData[countriesData[_CR].parentCode].owner.send(continentFee);
    } else {
      continentFee = 0;
    }

    /* worldFee = SafeMath.div(warPoolFee, 100); */
    if (((countriesData[_CR].cType) != 3) && (countriesData['CWR'].owner != 0)) {
      countriesData['WR'].owner.send(worldFee);
    } else {
      worldFee = 0;
    }


    // Old Price minus adminFee minus warPoolFee minus WorldFee minus Continent Fee
    // goes to previous owner.

    uint previousOwnerFee = oldPrice.sub(adminFee).sub(warPoolFee).sub(continentFee).sub(worldFee);


    oldOwner.send(previousOwnerFee);

    //Difference between oldPrice and ether send by the buyer goes back to him. Just in case he paid too much.
    uint moneyReturn = SafeMath.sub(msg.value, oldPrice);
    msg.sender.send(moneyReturn);

    uint newPrice = oldPrice.percent(120);

    //Set New Price and Set new Country Owner.
    countriesData[_CR].price = newPrice;

    RemoveUserCountry(_CR);
    AddUserCountry(_CR, msg.sender);
    BuyTransaction(bytes3ToStr(_CR), msg.sender, oldPrice, adminFee, warPoolFee, continentFee, worldFee);

    return true;

  }

  function BuyDefense(bytes3 _CR, uint _dType) public payable returns(bool) {
    require(countriesData[_CR].owner == msg.sender);
    require(countriesData[_CR].price > 0);
    require(_dType == 1 || _dType == 5 || _dType == 15);
    require(countriesData[_CR].defenses[_dType] == false);

    uint dValue = countriesData[_CR].price.permil(_dType);
    require(msg.value >= dValue);

    uint adminFee = dValue.percent(1);
    msg.sender.send(msg.value.sub(dValue));
    owner.send(adminFee);

    if ((usersAttacks[msg.sender] == 0) && (usersDefenses[msg.sender] == 0 )) {
      contributors.push(msg.sender);
    }
    usersDefenses[msg.sender] += dValue;
    totalDefense += dValue;

    countriesData[_CR].defenses[_dType] = true;
    return true;
  }

  //Check if country has a defense, but not use it.
  function HasDefense(bytes3 _CR, uint _dType) public constant onlyOwner returns(bool) {
    return countriesData[_CR].defenses[_dType];
  }


//Set Phase Time 0- peace, 1-alliance, 2 - war.
function SetStateTime(uint _state,uint _days, uint _hours) public onlyOwner {
  require(_state == 0 || _state == 1 || _state == 2);
  require(_days >= 0); // it has to be minimum one hour. So days can be set to zero.
  require(_hours>0);
  timersDays[_state] = _days;
  timersHours[_state] = _hours;

  //If we are in peace state it is possible to change end of this phase. in alliance and war new timers will be taken into account after new round.
  if(worldstate==0 && _state == 0)
  {
    uint tmpEndPhase = phaseStarts + (_days*24*3600) + (_hours*3600);
    if ( now > tmpEndPhase)
    {
      return;
    }
    else {
      phaseEnds = tmpEndPhase;
    }


  }

  TimersUpdated();

}

function GetStateTimers() public  constant returns (uint pd, uint ph,uint ad, uint ah,uint wd, uint wh)
{
 return (timersDays[0], timersHours[0],timersDays[1], timersHours[1],timersDays[2], timersHours[2]);
}

function GetPhaseTimers() public constant returns (uint phase, uint start, uint end)
{
return (worldstate, phaseStarts, phaseEnds);
}

function GetCountryDefenses (bytes3 _CR) public constant returns (bytes3 ccode,bool d1,bool d5,bool d15)
  {
    require (countriesData[_CR].owner == msg.sender); //country defense can be checked only by it's owner.
    bool defense1 = countriesData[_CR].defenses[1];
    bool defense5 = countriesData[_CR].defenses[5];
    bool defense15 = countriesData[_CR].defenses[15];
    NewDefense();

    return (_CR, defense1, defense5, defense15);

  }

  //Use defense and return true if there was a defense and false if there was no defense.
  function Defended(bytes3 _CR, uint _dType) private returns(bool) {
    require(countriesData[_CR].price > 0);
    require(_dType == 1 || _dType == 5 || _dType == 15);

    if (countriesData[_CR].defenses[_dType] == true) {
      countriesData[_CR].defenses[_dType] = false;
      return true;
    } else {
      return false;
    }

  }

  function AttackCountry(bytes3 _CR, uint _aPer) public payable returns(bool) {

    /* Attack('TE', 2); */
    require(countriesData[_CR].owner != 0);
    require(OwnCountry(msg.sender) > 0); //attacker must own the country. excluding world or continent.

    require(usersAlliance[msg.sender] != usersAlliance[countriesData[_CR].owner]);
    require(msg.sender != countriesData[_CR].owner);
    require((_aPer == 1) || (_aPer == 5) || (_aPer == 15) || (_aPer == 25));
    require(countriesData[_CR].attacks + _aPer <= 25);
    require(countriesData[_CR].cType == 1); //you can only attack normal countries.

    uint attackPrice = countriesData[_CR].price.percent(_aPer);
    require(msg.value >= attackPrice);
    //Give them money back if they decided to send too much money for attack.
    msg.sender.send(SafeMath.sub(msg.value, attackPrice));

    //Calculate Fees.

    //Calculate Admin Fee and send it to contract owner.
    uint adminFee = attackPrice.percent(adminPer);
    owner.send(adminFee);

    //Calculate Continent Fee
    uint continentFee = attackPrice.percent(continentPer);
    if (countriesData[countriesData[_CR].parentCode].owner != 0) {
      countriesData[countriesData[_CR].parentCode].owner.send(continentFee);
    }

    //Calculate World Fee
    uint worldFee = attackPrice.percent(worldPer);
    countriesData['WR'].owner.send(worldFee);

    CountryAttacked(msg.sender, _CR, _aPer, attackPrice, HasDefense(_CR, _aPer));
    UpdateAttackPrice(msg.sender, _aPer, attackPrice, _CR);
    return true;

  }

  //change prices of all countries being attacked and countries attacking and update all war counters.
  function UpdateAttackPrice(address _attacker, uint _aPer, uint _price, bytes3 _CR) {
    require(_price > 0);
    require(_attacker != 0);
    require(countriesData[_CR].price > 0);

    //Add attack Percentage to attacks for this countriesData
    if (Defended(_CR, _aPer) == false) {
      countriesData[_CR].attacks += _aPer;
      //Change country price.
      countriesData[_CR].price -= _price;
    }
    else{
      if (usersAlliance[_attacker] == 1) {
        alliance1Attacks += _price;
      }
      if (usersAlliance[_attacker] == 2) {
        alliance2Attacks += _price;
      }
    }

    //If user didn't attack before then add him to the list of attackers.
    if ((usersAttacks[msg.sender] == 0) && (usersDefenses[msg.sender] == 0 )) {
      contributors.push(_attacker);
    }
    usersAttacks[_attacker] += _price;



  }

  //Return amount of countries owned by user.
  function UserBalance(address _owner) public returns(uint) {

    if (_owner == 0) {
      _owner = msg.sender;
    }
    return userCountries[_owner].length;
  }

  //Remove country from the user list.
  function RemoveUserCountry(bytes3 _CR) public returns(bool) {
    require(countriesData[_CR].owner != 0);

    address oldOwner = countriesData[_CR].owner;
    uint lastCountryIndex = UserBalance(oldOwner).sub(1);
    require(lastCountryIndex >= 0); //if it is less than zero than it means that user has no countries.
    uint countryIndex = countryUserIndex[_CR];
    require(countryIndex >= 0); // if it is zero it means that country wasn't part of user list.
    countryUserIndex[_CR] = 0;
    bytes3 lastCountry = userCountries[oldOwner][lastCountryIndex];
    userCountries[oldOwner][countryIndex] = userCountries[oldOwner][lastCountryIndex];
    if (lastCountryIndex != countryIndex) //if you delete last country from the list then you don't want to keep old index.
    {
      countryUserIndex[lastCountry] = countryIndex;
    }
    userCountries[oldOwner].length--; //short list of countries by one.
    countriesData[_CR].owner = 0;
    if (countriesData[_CR].cType == 1) {
      userCountryCounter[oldOwner]--;
    }

    return true;
  }

  function AddUserCountry(bytes3 _CR, address _newUser) public returns(bool) {
    require(_newUser != 0);
    require(countriesData[_CR].price > 0); //make sure that country exist in the list
    require(countriesData[_CR].owner == 0);
    require(countryUserIndex[_CR] == 0);

    countriesData[_CR].owner = _newUser;

    uint newIndex = UserBalance(_newUser);
    userCountries[_newUser].push(_CR);
    countryUserIndex[_CR] = newIndex;

    if (countriesData[_CR].cType == 1) {
      userCountryCounter[_newUser]++;
    }

    return true;

  }


  function UserCountries(address _user) public constant returns(bytes3[]) {
    if (_user == 0) {
      _user = msg.sender;
    }
    return userCountries[_user];
  }

  //Return amount of countries owned by user.It ignores continents and world.
  function OwnCountry(address _owner) public constant returns(uint) {


    if (_owner == 0) {
      _owner = msg.sender;
    }
    return userCountryCounter[_owner];

  }

  function GetAllianceValue(uint _alliance) public constant returns(uint) {
    uint i = 0;
    uint allianceValue = 0;
    for (i = 0; i < countries.length; i++) {
      bytes3 ccode = countries[i];
      address countryOwner = countriesData[ccode].owner;

      if (usersAlliance[countryOwner] == _alliance) {
        allianceValue = allianceValue + countriesData[ccode].price;
      }
    }
    return allianceValue;
  }

 function GetAllianceScore(uint _alliance) public constant returns (uint)
 {
   if(_alliance == 1)
   {
     return alliance1Attacks;
   }
   if(_alliance == 2){
     return alliance2Attacks;
   }
   throw;
 }

  function ForceAlliance() private {
    uint i = 0;
    for (i = 0; i < countries.length; i++) {
      bytes3 ccode = countries[i];
      address user = countriesData[ccode].owner;
      if(usersAlliance[user] == 0)
      {
        uint a1 = GetAllianceValue(1);
        uint a2 = GetAllianceValue(2);

        if(a1 < a2 ) {
          usersAlliance[user] = 1;
            AllianceChanged(user, 1);
        }
        else
        {
          usersAlliance[user] = 2;
          AllianceChanged(user, 2);
        }

      }

    }
  }

  /* function GetAllianceCountries(uint _alliance) public constant returns (bytes3[])
  {
    uint i = 0;
    bytes3[] tmpCountries;
    for (i=0;i<countries.length;i++) {
      bytes3 ccode = countries[i];
      address countryOwner = countriesData[ccode].owner;

      if(usersAlliance[countryOwner] == _alliance)
      {
        tmpCountries.push(ccode);
      }
    }
    return tmpCountries;

  } */
  //Set your own alliance. You can't change other user alliance.
  function SetAlliance(uint alliance) public returns(bool) {
    /* require(usersAlliance[msg.sender] == 0); */
    require(alliance == 1 || alliance == 2 || alliance == 0);
    usersAlliance[msg.sender] = alliance;
    AllianceChanged(msg.sender, alliance);

    return true;
  }

  //Testing only
  function ChangeAlliance(address _user) public onlyOwner returns(bool) {
    /* usersAlliance.length=0; */
    usersAlliance[_user] = 0;
    AllianceChanged(msg.sender, 0);
    return true;
  }

  //Set your own alliance. You can't change other user alliance.
  function GetCountryAlliance(bytes3 _CR) public constant returns(uint, string) {

    return (usersAlliance[countriesData[_CR].owner], bytes3ToStr(_CR));
  }

  function GetMyAlliance() public constant returns(uint) {
    return usersAlliance[msg.sender];
  }

  // winner says who won the war 1- alliance1, 2-alliance2, 0-draw, a1value - amount of Wei spend by alliance2,
  // a2Value -amount of wei spend by alliance 2, timestamp, moment when war was finished.
  //timestamp of end of war is equal to timestamp of each transaction for each user.
  event WarResult(uint winner, uint a1value, uint a2value, uint timestamp);
  event UserWarShare(address user, uint share, uint value, uint timestamp);
  //this function finish war and send money to each user
  function FinishWar()  internal returns(bool) {

    uint timestamp = now;
    uint contributorsAmount = contributors.length;
    uint winner;
    uint totalSpending = alliance1Attacks + alliance2Attacks + totalDefense;
    assert (worldstate == 2); //this function can be called only when there is a war.
    //it is a defect when finsh was is called when there was no war.

    //5% of warpool money rolls to another war.
    uint warpool = this.balance.percent(95);


    //Alliance 1 won
    if (alliance1Attacks > alliance2Attacks) {
      winner = 1;
      WarResult(winner, alliance1Attacks, alliance2Attacks, timestamp);
    }
    //Alliance 2 won
    if (alliance2Attacks > alliance1Attacks) {
      winner = 2;
      WarResult(winner, alliance1Attacks, alliance2Attacks, timestamp);

    }

    //Draw
    if (alliance1Attacks == alliance2Attacks) {
      winner = 0;
      WarResult(winner, alliance1Attacks, alliance2Attacks, timestamp);

      return false;
    }
    for (uint i = 0; i < contributors.length; i++) {
      if (usersAlliance[contributors[i]] == winner) {
        uint userSpending = usersAttacks[contributors[i]] + usersDefenses[contributors[i]];
        uint share = userSpending.ratio(totalSpending);
        uint userShare = warpool.percent(share);
        contributors[i].send(userShare);
        UserWarShare(contributors[i],share,userShare,timestamp);
      }
    }
    return true;
  }


  function CleanAfterWar() public onlyOwner {


    for (uint i =0; i< contributors.length;i++)
    {
      usersAttacks[contributors[i]] = 0;
      usersDefenses[contributors[i]] = 0;
      delete contributors[i];

    }
    contributors.length = 0;
    alliance1Attacks = 0;
    alliance2Attacks = 0;
    totalDefense = 0;
    drawNumber = 0;

    for (i = 0; i < countries.length; i++) {
      countriesData[countries[i]].attacks = 0;

      //Clean countries defenses.
      countriesData[countries[i]].defenses[1] = false;
      countriesData[countries[i]].defenses[5] = false;
      countriesData[countries[i]].defenses[15] = false;

      //Change alliance of each user who bought anything to zero.
      usersAlliance[countriesData[countries[i]].owner] = 0;
    }
  }


}
