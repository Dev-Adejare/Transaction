// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract BuyMeACoffe {
    event NewMemo(address indexed from, uint256 timestamp, string name, uint256 amount,  string message);

    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        uint256 amount;
        string message;
    }

    address payable public owner;

    Memo[] memos;

    modifier onlyOwner(){
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor() {
        owner = payable (msg.sender);
    }

    function buyCoffee( string memory _name, string memory _message) public external payable {
        require(msg.value > 0, "Cannot buy coffee for free!");
        memos.push(Memo(msg.sender, block.timestamp, _name, msg.value, _message));

        emit NewMemo(msg.sender, block.timestamp, _name, msg.value, _message);
    }

    function withdrawTips() external onlyOwner {
        (bool success,) = owner.call{value: address(this).balance}("");
        require(success, "Withdrawal Failed");
    }

    function getMemos() external view returns (Memo[] memory) {
        return memos;
    }
}