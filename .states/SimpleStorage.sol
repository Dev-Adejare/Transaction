// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract SimpleStorage {
    uint32 public vaultNumber;

    function setNum(uint32 _num) public returns (bool) {
        vaultNumber = _num;
        return true;
    }
    
    //Getter function which returns all the argument we pass in the function
    function getNum() public view returns (uint32 num_, uint32 vatN_) {
        num_ = vaultNumber;
        uint32 vat = 50;
        (uint32 mul_, , uint32 div_) = calculateReward(vaultNumber, vat);
        vatN_ = mul_ + div_;
    }

    // This private function make is an Helper method which does not expose the code to the public
    function calculateReward(uint32 _vaultNum, uint32 _vat)
        private
        pure
        returns (
            uint32 mul_,
            uint32 add_,
            uint32 div_
        )
    {
        mul_ = _vaultNum * _vat;
        add_ = _vaultNum + _vat;
        div_ = _vaultNum / _vat;
    }
}
