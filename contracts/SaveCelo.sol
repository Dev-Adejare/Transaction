// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import {IERC20} from "./Icelo.sol";

contract SaveCelo{

    address celotoken;
    address owner;

    struct UserAccount{
        uint256 balance;
        uint256 duration;
    }

    mapping (address => UserAccount[]) users; 

    constructor(address _tokenAddress)



}