// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_12 {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function multiply(uint256 _value) public pure returns (uint256) {
        return _value * 2;
    }

    function multiplyByThree(uint256 _value) external pure returns (uint256) {
        return _value * 3;
    }
}
