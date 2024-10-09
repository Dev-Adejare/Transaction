// SPDX-License-Identifier: MIT
// This line specifies the license type for the contract, which is "MIT" in this case. 
// SPDX is a standardized way of declaring software licenses in source code.

pragma solidity ^0.8.27;
// This line specifies the version of the Solidity compiler that should be used. 
// The contract is written for Solidity version 0.8.27.

contract SimpleStorage {
    // Define a public state variable "vaultNumber" of type uint32 (unsigned 32-bit integer).
    uint32 public vaultNumber;

    // A function named "setNum" that takes a uint32 input "_num" and sets "vaultNumber" to this value.
    // The function is public (can be called from outside the contract) and returns a boolean value (true).
    function setNum(uint32 _num) public returns (bool) {
        vaultNumber = _num; // Set the vaultNumber to the input value "_num".
        return true;        // Return true to indicate the operation was successful.
    }
    
    // A getter function named "getNum" that returns two uint32 values: "num_" and "vatN_".
    // The "view" keyword means it doesn't modify the blockchain state (no gas fees for calling it).
    function getNum() public view returns (uint32 num_, uint32 vatN_) {
        num_ = vaultNumber; // Set "num_" to the value of the state variable "vaultNumber".
        uint32 vat = 50;    // Define a local uint32 variable "vat" and set it to 50.
        
        // Call the private helper function "calculateReward" with "vaultNumber" and "vat" as inputs.
        // The function returns three values, but we only care about the first (mul_) and third (div_).
        (uint32 mul_, , uint32 div_) = calculateReward(vaultNumber, vat);
        
        // Set "vatN_" to the sum of "mul_" (vaultNumber * vat) and "div_" (vaultNumber / vat).
        vatN_ = mul_ + div_;
    }

    // A private helper function named "calculateReward" that takes two uint32 inputs: "_vaultNum" and "_vat".
    // The function returns three uint32 values: "mul_", "add_", and "div_".
    // The "pure" keyword indicates that the function doesn't read or modify the contract's state, only performs computations.
    function calculateReward(uint32 _vaultNum, uint32 _vat)
        private
        pure
        returns (
            uint32 mul_, // Product of "_vaultNum" and "_vat".
            uint32 add_, // Sum of "_vaultNum" and "_vat".
            uint32 div_  // Division of "_vaultNum" by "_vat".
        )
    {
        // Calculate and assign values to the return variables.
        mul_ = _vaultNum * _vat;  // Multiply "_vaultNum" by "_vat".
        add_ = _vaultNum + _vat;  // Add "_vaultNum" and "_vat".
        div_ = _vaultNum / _vat;  // Divide "_vaultNum" by "_vat" (integer division).
    }
}
