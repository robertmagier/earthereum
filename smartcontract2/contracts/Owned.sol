pragma solidity ^0.4.18;

contract Owned {
    address public owner = 0;

     modifier onlyOwner () {
       require(owner == msg.sender);
       _;
     }

     function Owned(){
        owner = msg.sender;
     }

     function transferOwnsership(address _newOwner) public onlyOwner {
       require (_newOwner != 0);
       owner = _newOwner;
     }

}
