// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_10 {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function isFutureTimestamp(uint256 _timestamp) public view returns (bool) {
        return _timestamp > block.timestamp;
    }

    function isPastTimestamp(uint256 _timestamp) external view returns (bool) {
        return _timestamp < block.timestamp;
    }
}
