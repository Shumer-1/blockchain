// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_07 {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function getBytes(uint256 _value) public pure returns (bytes memory) {
        return abi.encodePacked(_value);
    }

    function getBytesFromString(string memory _text) external pure returns (bytes memory) {
        return bytes(_text);
    }
}
