pragma solidity ^0.4.4;

contract Authorization {

    address internal admin;

    function Authorization() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        if(msg.sender != admin) throw;
        _;
    }

    function assert(bool x) internal {
        if (!x) throw;
    }
}

contract AegisCoinStop is Authorization {

    bool public stopped;

    function AegisCoinStop() {
        start();
    }

    modifier stoppable {
        assert (!stopped);
        _;
    }
    function stop() onlyAdmin {
        stopped = true;
    }
    function start() onlyAdmin {
        stopped = false;
    }

}

contract AegiesTestCoin is Authorization, AegisCoinStop {

//*************************************************************************
// Variables

    mapping (address => uint256) private Balances;
    mapping (address => mapping (address => uint256)) private Allowances;
    string public standard = "AegisTestCoin v1.0";
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public coinSupply;
    uint256 private balance;
    uint256 private sellPrice;
    uint256 private buyPrice;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
//*************************************************************************************
// End Variables

//**************************************************************************************
//Constructor
    function AegiesTestCoin(address beneficiaryAddress) {
        admin = msg.sender;
        Balances[admin] = 1500000000000000;             //15 million coins for a price of roughly $0.10 each : 15000000 * 10^8 : 1500000000000000
        coinSupply = 1500000000000000;
        decimals = 8;
        symbol = "AGST";
        name = "Aegis Test Coin";
        beneficiary = beneficiaryAddress;
        SetAegisTestCoinSale();
    }

//***************************************************************************************

//***************************************************************************************
// Base Token  Started ERC 20 Standards
    function totalSupply() constant returns (uint initCoinSupply) {
        return coinSupply;
    }

    function balanceOf (address _owner) constant returns (uint256 balance) {
        return Balances[_owner];
    }

    function transfer(address _to, uint256 _value) stoppable returns (bool success) {
        if(Balances[msg.sender] < _value) throw;
        if(Balances[_to] + _value < Balances[_to]) throw;

        Balances[msg.sender] -= _value;
        Balances[_to] += _value;

        Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) stoppable returns (bool success) {
        if(Balances[_from] < _value) throw;
        if(Balances[_to] + _value < Balances[_to]) throw;
        if(_value > Allowances[_from][msg.sender]) throw;
        Balances[_from] -= _value;
        Balances[_to] += _value;
        Allowances[_from][msg.sender] -= _value;
        Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _sbalanceOfpender, uint256 _value) stoppable returns (bool success) {
        Allowances[msg.sender][_sbalanceOfpender] = _value;
        Approval(msg.sender, _sbalanceOfpender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) stoppable constant returns (uint256 remaining) {
        return Allowances[_owner][_spender];
    }
    //***********************************************************************************************
    //End Base Token
    //

    function OBEFAC(address addr) onlyAdmin public {
        beneficiary = addr;
    }

/*    function priceOfTokenInETH(uint256 _value) onlyAdmin public {
        priceInWei = _value;
    }
*/
    function releaseTokens (address _to, uint256 _value) private returns (bool success) {

        if(Balances[admin] < _value) throw;
        if(Balances[_to] + _value < Balances[_to]) throw;


        Balances[admin] -= _value;
        Balances[_to] += _value;

        Transfer(admin, _to, _value);

        return true;
    }

    //***********************************************************************************************
    //Crowd Sale Logic
    //

    enum State {
        Fundraising,                    //initial state of crowdsale
        Failed,                         //failed to achieve the minimum target
        Successful,                     //funding is successfull but not yet transfered the funds to the founders
        Closed                          //everything is done i.e. the purpose of crowdsale is over
    }
    State private state = State.Fundraising; // setting the default state to fundraising

    struct Contribution {
        uint amount;                    //amount(in ETH) the person has contributed
        address contributor;
    }
    Contribution[] contributions;

    uint256 private totalRaised = 0;
    uint256 private currentBalance;        //currentBalance can be less than totalRaised in case of refund
    uint private deadline;
    uint private completedAt;
    uint256 private priceInWei;            //price of token (e.g. 1 token = 1 ETH i.e. 10^18 Wei )
    uint256 private fundingMinimumTargetInWei;
    uint256 private fundingMaximumTargetInWei;
    address private creator;            //who created the crowdsale
    address private beneficiary;        //beneficiary can also be a DAO
    string private campaignUrl;
    byte constant version = 1;

    uint256 private amountInWei=0;
    uint256 private tempTotalRasiedFunds=0;
    uint256 private actualValue=0;
    uint256 private refundAmount = 0;
    uint256 private fundingTokens=0;

    event LogRefund(address addr, uint amount);
    event LogFundingReceived(address addr, uint amount, uint currentTotal); //funds received by contributors
    event LogWinnerPaid(address winnerAddress);                             //whether the beneficiary has paid or not
    event LogFundingSuccessful(uint totalRaised);                           //will announce when funding is successfully completed
    event LogFunderInitialized(
    address creator,
    address beneficiary,
    string url,
    uint _fundingMaximumTargetInEther,
    uint256 deadline);

    modifier inState(State _state) {
        if (state != _state) throw;
        _;
    }

    function SetAegisTestCoinSale()
    private
    {
        creator = msg.sender;
        campaignUrl = "www.aegissmartcontracts.com";
        fundingMinimumTargetInWei = 952.38095238 * 1 ether;  //the soft cap is $500,000 : 952.38095238 ethers
        fundingMaximumTargetInWei = 2857.1428571 * 1 ether;  //the hard cap is $1.5 million : 2857.1428571 ethers
        deadline = now + (41760 * 1 minutes);                //ICO Period: 6th of April - 4th of May: 41760 minutes
        currentBalance = 0;
        priceInWei = 0.000190476190476 * 1 ether;                 //one ether equals 5250 AGS tokens. : 1 AGS = 0.0001904761 ethers
        LogFunderInitialized(
        creator,
        beneficiary,
        campaignUrl,
        fundingMaximumTargetInWei,
        deadline);
    }

    function contribute(address _sender)
    private
    inState(State.Fundraising)
    stoppable
    returns (uint256)
    {
        uint256 _value = msg.value;
        amountInWei = _value;
        tempTotalRasiedFunds = totalRaised + _value;
        actualValue = _value;
        if (fundingMaximumTargetInWei != 0 && tempTotalRasiedFunds > fundingMaximumTargetInWei) {
            refundAmount = tempTotalRasiedFunds-fundingMaximumTargetInWei;
            actualValue = _value-refundAmount;
        }
        contributions.push(
            Contribution({
                amount: actualValue,
                contributor: _sender
            })
        );

        if ( refundAmount > 0 ) {
            if (!_sender.send(refundAmount)) {
                throw;
            }
            LogRefund(_sender,refundAmount);
        }

        totalRaised += actualValue;
        currentBalance = totalRaised;

        fundingTokens = (actualValue * 100000000) / priceInWei;         // Just for readability: (actualValue*10^(8)/ priceInWei)
        releaseTokens(_sender, fundingTokens);
        LogFundingReceived(_sender, actualValue, totalRaised);
        checkIfFundingCompleteOrExpired();
        return contributions.length - 1;                                // this will return the contribution ID
    }

    //************************************************************************************/
    // To check if funding is given to the founders or the beneficiaries

    function checkIfFundingCompleteOrExpired()
    private
    {
        if (fundingMaximumTargetInWei != 0 && totalRaised >= fundingMaximumTargetInWei) {
            state = State.Successful;
            LogFundingSuccessful(totalRaised);
            payOut();
            completedAt = now;

        } else if ( now > deadline ) {
            if(totalRaised >= fundingMinimumTargetInWei) {
                state = State.Successful;
                LogFundingSuccessful(totalRaised);
                payOut();
                completedAt = now;
            } else {
                state = State.Failed;
                completedAt = now;
            }
        }
    }

    function getPayOut()
    public
    onlyAdmin
    {
        checkIfFundingCompleteOrExpired();
    }

    function getRefund()
    public
    {
        checkIfFundingCompleteOrExpired();
        callGetRefund();
    }

    function payOut()
    private
    inState(State.Successful)
    {
        if(!beneficiary.send(this.balance)) {
            throw;
        }
        state = State.Closed;
        currentBalance = 0;
        LogWinnerPaid(beneficiary);
    }

    function callGetRefund()
	private
	inState(State.Failed)
	{
		for(uint i=0; i<contributions.length; i++) {

            if(contributions[i].contributor == msg.sender) {
				uint amountToRefund = contributions[i].amount;
				contributions[i].amount = 0;

            	if(!contributions[i].contributor.send(amountToRefund)) {
					contributions[i].amount = amountToRefund;
					throw;
				} else {
					totalRaised -= amountToRefund;
					currentBalance = totalRaised;
				}
			}
		}
	}

    function removeContract()
	public
	onlyAdmin
	{
		selfdestruct(beneficiary);
	}

    function ()
    payable
    inState(State.Fundraising)
    {
        contribute(msg.sender);
    }
}
