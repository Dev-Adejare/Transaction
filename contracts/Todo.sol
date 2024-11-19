

// // Define a contract named "TodoList"
// contract TodoList {
    
//     // Declare a public variable "owner" of type address, which will hold the address of the contract owner.
//     address public owner;

//     // Define an enumeration (enum) named "Status" with four possible states for a todo: None, Created, Edited, and Done.
//     enum Status { None, Created, Edited, Done }

//     // Define a struct named "Todo" that represents a task. 
//     // It includes a title (string), a description (string), and a status (from the Status enum).
//     struct Todo {
//         string title;
//         string description;
//         Status status;
//     }

//     // Declare a public dynamic array of "Todo" structs named "todos".
//     Todo[] public todos;

//     // Constructor function that is called when the contract is deployed.
//     // It sets the "owner" variable to the address of the person who deployed the contract (msg.sender).
//     constructor() {
//         owner = msg.sender;
//     }

//     // A modifier named "onlyOwner" that restricts access to certain functions.
//     // It checks if the sender (msg.sender) is the owner of the contract.
//     // If not, it throws an error with the message "You're not allowed".
//     modifier onlyOwner() {
//         require(msg.sender == owner, "You're not allowed");
//         _; // This means "continue execution", placing the modifier in the function where it is used.
//     }

//    // Define a modifier named "validAddress"
// modifier validAddress() {
    
//     // Ensure that the address calling the function (msg.sender) is not the zero address (0x0000000000000000000000000000000000000000).
//     // If msg.sender is the zero address, the transaction is reverted with the error message "Zero address not allowed".
//     require(msg.sender != address(0), "Zero address not allowed");
    
//     // This placeholder allows the execution of the rest of the function that uses this modifier, 
//     // meaning the code in the function continues after the modifier checks are passed.
//     _;
// }

//    // Define an event named "TodoCreated" that logs when a new todo is created.
// // It takes two parameters: a string "title" and a "Status" value.
// event TodoCreated(string title, Status status);

// function createTodo(string memory _title, string memory _desc)
//     external
//     onlyOwner
//     validAddress
//     returns (bool)
// {
//     // Create a new instance of the "Todo" struct (defined earlier in the contract).
//     Todo memory mytodo;
    
//     // Set the "title" of the new todo to the value of the "_title" parameter.
//     mytodo.title = _title;
    
//     // Set the "description" of the new todo to the value of the "_desc" parameter.
//     mytodo.description = _desc;
    
//     // Set the "status" of the new todo to "Status.Created" (an enum value).
//     mytodo.status = Status.Created;
    
//     // Push (add) the newly created "mytodo" struct to the "todos" array.
//     todos.push(mytodo);

//     // Emit the "TodoCreated" event, logging the new todo's title and status.
//     emit TodoCreated(_title, Status.Created);

//     // Return true to indicate that the todo was successfully created.
//     return true;
// }

// function updateTodo(uint8 _index, string memory _title, string memory _desc) 
//     external 
//     onlyOwner 
//     validAddress 
// {
//     // Ensure that the provided index is within the bounds of the "todos" array.
//     // If "_index" is greater than or equal to the length of the "todos" array, it will revert with the message "Index is out-of-bound".
//     require(_index < todos.length, "Index is out-of-bound");

//     // Access the "Todo" struct at the given index in the "todos" array. 
//     // Use "storage" so that changes to "mytodo" will persist on the blockchain.
//     Todo storage mytodo = todos[_index];

//     // Update the title of the selected todo with the new value provided in "_title".
//     mytodo.title = _title;

//     // Update the description of the selected todo with the new value provided in "_desc".
//     mytodo.description = _desc;

//     // Update the status of the selected todo to "Status.Edited" to indicate that it has been modified.
//     mytodo.status = Status.Edited;
// }

// function getTodo(uint8 _index) external view validAddress returns (string memory, string memory, Status) {
//     // Ensure the index is within the valid range of the "todos" array.
//     require(_index < todos.length, "Index is out-of-bound");

//     // Retrieve the todo at the specified index from the "todos" array.
//     Todo memory mytodo = todos[_index];

//     // Return the title, description, and status of the retrieved todo.


//     return (mytodo.title, mytodo.description, mytodo.status);
// }
// function getAllTodo() external view validAddress returns (Todo[] memory) {
//     // Return the entire "todos" array stored in the contract.
//     return todos;
// }
// function todoCompleted(uint8 _index) external onlyOwner validAddress returns (bool) {
//     // Ensure the index is within the valid range of the "todos" array.
//     require(_index < todos.length, "Index is out-of-bound");

//     // Access the todo at the specified index from the "todos" array in storage.
//     Todo storage mytodo = todos[_index];

//     // Update the status of the todo to "Status.Done" (completed).
//     mytodo.status = Status.Done;

//     // Return true to indicate the status update was successful.
//     return true;
// }
// function deleteTodo(uint8 _index) external onlyOwner validAddress {
//     // Ensure the index is within the valid range of the "todos" array.
//     require(_index < todos.length, "Index is out-of-bound");

//     // Replace the todo at "_index" with the last todo in the array.
//     todos[_index] = todos[todos.length - 1];

//     // Remove the last todo from the array (since it was moved).
//     todos.pop();
// }






// }


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract TodoList {
    address public owner;
    enum Status {None, Created, Edited, Done}

    struct Todo {
        string title;
        string description;
        Status status;
    }

    Todo[] public todos;

    constructor() {
        owner = msg.sender;
    }

    modifier  onlyOwner() {
        require(msg.sender == owner, "You're not allowed");
        _;
    }

    modifier validAddress (){
        require(msg.sender != address(0), "Zero address not allowed");
        _;
    }

    event TodoCreated(string title, Status status);
    event TodoUpdated(string title, Status status);
    event  TodoDeleted();

    function createTodo(string memory _title, string memory _desc) external onlyOwner validAddress  returns (bool){
        Todo memory mytodo;
        mytodo.title = _title;
        mytodo.description = _desc;
        mytodo.status = Status.Created;
       
        todos.push(mytodo);

        emit TodoCreated(_title, Status.Created);

        return true;
    }

    function updateTodo(uint8 _index, string memory _title, string memory _desc) external onlyOwner validAddress {
    require(_index < todos.length, "Index is out-of-bound");

    Todo storage mytodo = todos [_index];
    mytodo.title = _title;
    mytodo.description = _desc;
    mytodo.status = Status.Edited;

    emit TodoUpdated(_title, Status.Edited);

    } 

    function getTodo(uint8 _index) external view validAddress returns (string memory, string memory, Status){
    require(_index < todos.length, "Index is out-of-bound");

    Todo memory mytodo = todos[_index];
    return (mytodo.title, mytodo.description, mytodo.status);
    }


    function getAllTodo() external view validAddress returns (Todo[] memory){
        return todos;
    }

    function todoCompleted(uint8 _index) external onlyOwner validAddress returns (bool){
        require(_index < todos.length, "Index is out-of-bound");

    Todo storage mytodo = todos[_index];
    mytodo.status = Status.Done;

    return true;

    }

    function deleteTodo(uint8 _index) external onlyOwner validAddress{
        require(_index < todos.length, "Index is out-of-bound");

        todos[_index] = todos[todos.length - 1];
        todos.pop();
        emit TodoDeleted();

    }
}



