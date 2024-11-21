// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract TodoList {
    address public owner;

    enum Status {
        None,
        Created,
        Edited,
        Done
    }

    struct Todo {
        string title;
        string description;
        Status status;
    }

    Todo[] public todos;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You're not allowed");
        _;
    }

    modifier validAddress() {
        require(msg.sender != address(0), "Zero Address not allowed");
        _;
    }

    event TodoCreated(string title, string description, Status status);
    event TodoUpdated(uint8 index, string title, string description, Status status);
    event TodoCompleted(uint8 index, Status status);
    event TodoDeleted(uint8 index);

    event TodoDeleted();

    function createTodo(string memory _title, string memory _desc)
        external
        onlyOwner
        validAddress
        returns (bool)
    {
        Todo memory mytodo;
        mytodo.title = _title;
        mytodo.description = _desc;
        mytodo.status = Status.Created;

        todos.push(mytodo);

        emit TodoCreated(_title, _desc, Status.Created);
        return true;
    }

    function updateTodo(
        uint8 _index,
        string memory _title,
        string memory _desc
    ) external onlyOwner validAddress returns (bool) {
        require(_index < todos.length, "Index is Out_of_bound");

        Todo storage mytodo = todos[_index];
        mytodo.title = _title;
        mytodo.description = _desc;
        mytodo.status = Status.Edited;

        emit TodoUpdated( _index, _title, _desc, Status.Edited);

        return true;
    }

    function getTodo(uint8 _index)
        external
        view
        returns (
            string memory,
            string memory,
            Status
        )
    {
        require(_index < todos.length, "Index is Out_of_bound");
        Todo storage mytodo = todos[_index];
        return (mytodo.title, mytodo.description, mytodo.status);
    }

    function getAllTodo() public view returns (Todo[] memory) {
        return todos;
    }

    function deleteTodo(uint8 _index) public {
        require(_index < todos.length, "Index is Out_of_bound");
        todos[_index] = todos[todos.length - 1];
        todos.pop();

        emit TodoDeleted(_index);
    }

    function todoCompleted(uint8 _index)
        public
        onlyOwner
        validAddress
        returns (bool)
    {
        require(_index < todos.length, "Index is Out_of_bound");

        Todo storage mytodo = todos[_index];

        mytodo.status = Status.Done;

         emit TodoCompleted(_index, Status.Done);

        return true;
    }
}