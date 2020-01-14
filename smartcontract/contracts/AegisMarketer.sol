pragma solidity 0.4.23;

import "./Owned.sol";
import "./SafeMath.sol";

contract ERC20Basic {
  function totalSupply() public view returns (uint256);
  function balanceOf(address who) public view returns (uint256);
  function transfer(address to, uint256 value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
}



contract AegisMarketer is Owned
{
  struct TokenClaim {
    uint256 tokenAmount;
    uint256 expirationTime;

  }

  ERC20Basic token;
  using SafeMath for uint256;
  using SafeMath for uint;
  //Map uniqe sha256 hash to structure TokenClaim which stores information about tokenAmount and expiraton time.
  mapping (bytes32 => TokenClaim) private claims;
  bytes32[] private hashList;
  uint256 claimedAmount;

constructor (ERC20Basic _token) {
  require (_token != address(0));
  token = _token;
}


  function AddClaim(bytes32 _hash, uint256 _amount, uint256 _days) public onlyOwner returns(bool)
  {
    require(_hash.length == 32);
    require (_amount > 0);
    require (_days > 0);
    require (claims[_hash].tokenAmount == 0);

    uint256 currentBalance = token.balanceOf(address(this));
    require(claimedAmount.add(_amount) <= currentBalance);

    claims[_hash].tokenAmount = _amount;
    claims[_hash].expirationTime = now + (_days*24 hours);
    hashList.push(_hash);
    currentBalance = currentBalance.add(_amount);

    return true;
  }

  function GenerateHashTest(string _securityText) public returns(bytes32)
  {
    return sha256(_securityText);
  }


function GetBalanceTest() public constant returns (uint256)
{
  return token.balanceOf(address(this));
}

  function GetHashList () public view returns (bytes32[])
  {
    return hashList;
  }

  function ClaimToken(bytes32 _securityText) public returns (bool)
  {
    require (_securityText.length == 32);
    bytes32 hash = sha3(_securityText);
    require (claims[hash].tokenAmount > 0);
    uint256 tokenAmount = claims[hash].tokenAmount;
    require(token.balanceOf(address(this)) >= tokenAmount);

    if (claims[hash].expirationTime < now ) // Claim expired and it has to be deleted.
    {
      claimedAmount = claimedAmount.sub(claims[hash].tokenAmount);
      delete claims[hash];

      return false;
    }
    else { //Claim is still valid and tokens can be transfered.
        if(token.transfer(msg.sender,tokenAmount))
        {
            claimedAmount = claimedAmount.sub(claims[hash].tokenAmount);
            delete claims[hash];
            return true;
        }
        else
        {
          return false;
        }
    }

  }


  function GetClaimInformation(bytes32 _hash) public view returns(uint256 _amount, uint256 _expirationDate)
  {
    require(_hash.length > 0);
    require (claims[_hash].tokenAmount > 0);

    return (claims[_hash].tokenAmount,claims[_hash].expirationTime);
  }


}
