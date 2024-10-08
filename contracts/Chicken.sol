// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract BaseStore {
    uint public plateOfRicePrice = 100;  
    uint public tableWaterPrice = 50;    
    uint public burgerPrice = 200;       
    uint public sharwamaPrice = 300;     

    function getPrices() public view virtual returns (uint, uint, uint, uint) {
        return (
            plateOfRicePrice, 
            tableWaterPrice, 
            burgerPrice, 
            sharwamaPrice
        );
    }
}

contract IkoroduStore is BaseStore {
    function getPrices() public view virtual override returns (uint, uint, uint, uint) {
        return (
            plateOfRicePrice * 10,
            tableWaterPrice * 10,
            burgerPrice * 10,
            sharwamaPrice * 10
        );
    }
}

contract MainlandStore is IkoroduStore {
    function getPrices() public view virtual override returns (uint, uint, uint, uint) {
        return (
            plateOfRicePrice * 15,
            tableWaterPrice * 15,
            burgerPrice * 15,
            sharwamaPrice * 15
        );
    }
}

contract VictoriaIslandStore is MainlandStore { 
    function getPrices() public view override returns (uint, uint, uint, uint) {
        return (
            plateOfRicePrice * 25,
            tableWaterPrice * 25,
            burgerPrice * 25,
            sharwamaPrice * 25
        );
    }
}
