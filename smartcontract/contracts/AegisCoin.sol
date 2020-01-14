pragma solidity ^0.4.18;

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

contract AegisCoin is Authorization, AegisCoinStop {

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
    address private contractAddr;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
//*************************************************************************************
// End Variables

    modifier onlyContract() {
        if(msg.sender != contractAddr) throw;
        _;
    }

//**************************************************************************************
//Constructor
    function AegisCoin(address beneficiaryAddress) {
        admin = msg.sender;
        Balances[admin] = 15000000000000000000000000; //15 million coins for a price of $0.10 each : 15000000 * 10^18 : 15000000000000000000000000
        coinSupply = 15000000000000000000000000;
        decimals = 18;
        symbol = "AGS";
        name = "Aegis Coin";
        beneficiary = beneficiaryAddress;
        contractAddr = admin;
        AegisCoinSale();
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

    function changeContractSenderAddress(address addr) onlyAdmin public {
        contractAddr = addr;
    }

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
        Fundraising,
        Failed,
        Successful,
        Closed
    }
    State public state = State.Fundraising;

    struct Contribution {
        uint256 amount;
        address contributor;
    }
    Contribution[] contributions;

    uint256 private totalRaised = 0;
    uint256 private totalRaisedInCents = 0;
    uint256 private currentBalance;
    uint private deadline;
    uint public startDate;
    uint private refundEndDate;
    uint private completedAt;
    uint256 private fundingMinimumTargetInCents;
    uint256 private fundingMaximumTargetInCents;
    address private creator;
    address private beneficiary;
    string private campaignUrl;
    uint256 private priceInCents;
    uint256 private ETHUSD;
    byte constant version = 1;

    uint256 private amountInWei=0;
    uint256 private tempTotalRasiedFunds=0;
    uint256 private tempTotalRasiedFundsInCents = 0;
    uint256 private actualValue=0;
    uint256 private refundAmount = 0;
    uint256 private refundAmountInCents=0;
    uint256 private fundingTokens=0;

    event newOraclizeQuery(string description);
    event LogRefund(address addr, uint256 amount);
    event LogFundingReceived(address addr, uint256 amount, uint256 currentTotal);
    event LogWinnerPaid(address winnerAddress);
    event LogFundingSuccessful(uint256 totalRaised);
    event LogFunderInitialized(
    address creator,
    address beneficiary,
    string url,
    uint _fundingMaximumTargetInCents,
    uint256 deadline);

    modifier inState(State _state) {
        if (state != _state) throw;
        if (now < startDate) throw;
        _;
    }

    modifier inRefundPeriod() {
        if (now > refundEndDate) throw;
        _;
    }

    modifier RefundPeriodExpired() {
        if (now < refundEndDate) throw;
        _;
    }

    function AegisCoinSale()
    private
    {
        creator = msg.sender;
        campaignUrl = "www.aegissmartcontracts.com";
        startDate = now + (0 * 1 minutes);                         // calculate minutes upto ICO start time
        deadline = startDate + (41760 * 1 minutes);                //ICO Period: 6th of April - 4th of May: 29 days: 41760 minutes
        refundEndDate = deadline + (5400 * 1 minutes);      // 3 month refund period expiry date
        currentBalance = 0;
        fundingMinimumTargetInCents = 50000000;             //the soft cap is $500,000
        fundingMaximumTargetInCents = 150000000;            //the hard cap is $1.5 million
        priceInCents = 10;
        LogFunderInitialized(
        creator,
        beneficiary,
        campaignUrl,
        fundingMaximumTargetInCents,
        deadline);
    }

    function contribute(address _sender, uint256 getPrice, uint256 _msgvalue)
    public
    inState(State.Fundraising)
    onlyContract
    stoppable
    returns (uint256)
    {
        amountInWei = _msgvalue;
        tempTotalRasiedFunds = totalRaised + _msgvalue;
        actualValue = _msgvalue;

        tempTotalRasiedFundsInCents = (tempTotalRasiedFunds * getPrice) / 1 ether;

        if (fundingMaximumTargetInCents != 0 && tempTotalRasiedFundsInCents > fundingMaximumTargetInCents) {
            refundAmountInCents = tempTotalRasiedFundsInCents-fundingMaximumTargetInCents;
            refundAmount = (refundAmountInCents * 1 ether ) / getPrice;
            actualValue = _msgvalue-refundAmount;
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

        totalRaisedInCents = (totalRaised * getPrice) / 1 ether;

        fundingTokens = (getPrice * actualValue) / priceInCents;
        releaseTokens(_sender, fundingTokens);
        LogFundingReceived(_sender, actualValue, totalRaised);
        checkIfFundingCompleteOrExpired();
        return contributions.length - 1;
    }

    //************************************************************************************/
    // To check if funding is given to the founders or the beneficiaries

    function checkIfFundingCompleteOrExpired()
    private
    {
        if (fundingMaximumTargetInCents != 0 && totalRaisedInCents >= fundingMaximumTargetInCents) {
            state = State.Successful;
            LogFundingSuccessful(totalRaised);
            payOut();
            completedAt = now;

        } else if ( now > deadline ) {
            if(totalRaisedInCents >= fundingMinimumTargetInCents) {
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
    inRefundPeriod
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
				uint256 amountToRefund = contributions[i].amount;
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
    RefundPeriodExpired
	onlyAdmin
	{
		selfdestruct(beneficiary);
	}

    function ()
    payable
    {

    }

    function GetContractState()
    public
    onlyContract
    returns (uint)
    {
        checkIfFundingCompleteOrExpired();
        uint num=uint(state);
        return num;
    }

    function GetStartDate()
    public
    onlyContract
    returns (uint)
    {
        return startDate;
    }

    function GetContractStateForFundraising()
    public
    onlyContract
    returns (uint)
    {
        uint num=uint(State.Fundraising);
        return num;
    }

}
