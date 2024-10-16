// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./IERC20.sol";

contract stakeXFI{
    IERC20 public XFIContract;
    IERC20 public MPXContract;

    address internal owner;
    address internal newOwner;

    bool internal locked;

    uint256 immutable MINIMUM_STAKE_AMOUNT = 1_000 * (10**18);
    uint256 immutable MAXIMUM_STAKE_AMOUNT = 100_000 * (10**18);

    uint32 constant REWARD_PER_SECOND = 1_000_000; //0.000001%

    struct Staker{
        uint256 amount;
        uint256 startTime;
        uint256 duration;
        uint256 reward;
        bool hasWithdraw;
    }

    mapping (address => Staker[]) stakers;

    constructor(address _xfiAddress, address _mpxAddress){
        XFIContract = IERC20(_xfiAddress);
        MPXContract = IERC20(_mpxAddress);
        
        owner = msg.sender;
    }

    event DepositSuccessful(address indexed staker, uint256 amount, uint256 indexed startTime);
    event WithdrawalSuccessful(address indexed staker, uint256 amount, uint256 indexed duration);
    event OwnershipTransfered(address indexed previousOwner, address indexed newOwner);

    modifier onlyOwner(){
        require(msg.sender == owner, "No Access");
        _;
    }

    modifier reentrancyGuard(){
        require(!locked, "Not allowed to re_enter");
        locked = true;
        _;
        locked = false;
    }

}