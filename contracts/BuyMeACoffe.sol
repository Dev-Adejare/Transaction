// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


contract BuyMeACoffee {

    event NewMemo (address indexed from, uint256 timestamp, string name, uint256 amount, string message);
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        uint256 amount;
        string message;
    }


    address payable  public owner;

    Memo[] memos;

    modifier  onlyOwner () {
        require(msg.sender == owner, "You are not owner");
     _;
    }
    


    constructor() {
        owner = payable(msg.sender);
    }

    function buyCoffer(string memory _name,  string memory _message) external  payable {

        require(msg.value > 0, "Cannot buy coffee for free!");

        memos.push(Memo(msg.sender, block.timestamp, _name, msg.value, _message));

        emit NewMemo(msg.sender, block.timestamp, _name, msg.value, _message);
    }


    function withdrawTips() external  onlyOwner {
        (bool success,) = owner.call{value: address(this).balance}("");

        require(success, "Withdrawal failed");
    }

    function changeOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "Owner cannot be zero address");
        owner = payable (_newOwner);
    }

    function getMemos() external  view returns(Memo[] memory) {
        return memos;
    }
}