// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./IERC20.sol";

contract stakeXFI{
    IERC20 public XFIContract;
    IERC20 public MPXContract;

    address internal owner;
    address internal newOwner;

    uint256 immutable MINIMUM_STAKE_AMOUNT;
    uint256 immutable MAXIMUM_STAKE_AMOUNT;

    uint32 constant REWARD_PER_SECOND = 1_000_000; //0.000001%

    struct stake{
        uint256 amount;
        uint256 startTime;
        uint256 duration;
        uint256 reward;
        bool hasWithdraw;
    }

}