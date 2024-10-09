// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// Define a contract named "TodoList"
contract TodoList {
    
    // Declare a public variable "owner" of type address, which will hold the address of the contract owner.
    address public owner;

    // Define an enumeration (enum) named "Status" with four possible states for a todo: None, Created, Edited, and Done.
    enum Status { None, Created, Edited, Done }

    // Define a struct named "Todo" that represents a task. 
    // It includes a title (string), a description (string), and a status (from the Status enum).
    struct Todo {
        string title;
        string description;
        Status status;
    }

    // Declare a public dynamic array of "Todo" structs named "todos".
    Todo[] public todos;

    // Constructor function that is called when the contract is deployed.
    // It sets the "owner" variable to the address of the person who deployed the contract (msg.sender).
    constructor() {
        owner = msg.sender;
    }

    // A modifier named "onlyOwner" that restricts access to certain functions.
    // It checks if the sender (msg.sender) is the owner of the contract.
    // If not, it throws an error with the message "You're not allowed".
    modifier onlyOwner() {
        require(msg.sender == owner, "You're not allowed");
        _; // This means "continue execution", placing the modifier in the function where it is used.
    }

   // Define a modifier named "validAddress"
modifier validAddress() {
    
    // Ensure that the address calling the function (msg.sender) is not the zero address (0x0000000000000000000000000000000000000000).
    // If msg.sender is the zero address, the transaction is reverted with the error message "Zero address not allowed".
    require(msg.sender != address(0), "Zero address not allowed");
    
    // This placeholder allows the execution of the rest of the function that uses this modifier, 
    // meaning the code in the function continues after the modifier checks are passed.
    _;
}
    function createTodo(string memory _title, string memory _desc) external onlyOwner returns (bool){
        
    }
}
