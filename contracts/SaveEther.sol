// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract SaveEther{

    address public owner;

    struct UserAccount{
        uint256 amount;
        uint256 duration;
    }

    mapping( address user => UserAccount) userInfo;

    constructor(){
        owner = msg.sender;
    }

    event Transfer(address indexed user, uint256 amount);

    function onlyOwner() private view{
        require(msg.sender == owner, "User not allowed");
    }

    function depositEther(uint256 _duration) public payable {
        require(msg.sender != address(0), "Not permitted");
        require(msg.value >= 1 ether, "Amount is too small");

        UserAccount memory useracct;
        useracct.amount = useracct.amount + msg.value;
        useracct.duration = block.timestamp + _duration;

        userInfo[msg.sender] = useracct;
    }

        //  <----Doposit Ether Function---->
    // This depositEther function allows users to deposit Ether 
    // into the contract, with checks for valid addresses and minimum
    //  deposit amounts. It creates or updates a UserAccount struct
    //   with the deposited amount and a calculated duration,
    //    storing it in the userInfo mapping for that user.

    function withdrawEther() public payable  {
        require(msg.sender != address(0),"Not permitted");

        UserAccount storage useracct = userInfo[msg.sender];

        require(useracct.amount >= 1 ether, "Balance is not enough");
        require(block.timestamp > useracct.duration, "Not yet due");

        uint256 bal = useracct.amount;

        useracct.amount = 0;
        useracct.duration = 0;

        (bool sent, ) = payable(msg.sender).call{value: bal}("");

        if(sent){
            emit Transfer(msg.sender, bal);
        }
    }

    // <----withdraw Ether---->

    // The withdrawEther function allows users to withdraw their deposited 
    // Ether after verifying that they have sufficient balance and that the
    //  withdrawal is due. It resets the user's account information and attempts
    //   to transfer the Ether to the user, emitting a Transfer event if successful.

    function getContractBalance() public view returns (uint256){
        onlyOwner();
        return address(this).balance;
    }

    function getDeopositInfo() public view returns (uint256, uint256){
        UserAccount storage userAcct = userInfo[msg.sender];

        return(userAcct.amount, userAcct.duration);
    }
}