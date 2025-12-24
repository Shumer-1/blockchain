// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_09 {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function getFixedByteArraySum(bytes1[4] memory _data) public pure returns (uint8) {
        uint8 sum = 0;
        for (uint8 i = 0; i < _data.length; i++) {
            sum += uint8(_data[i]);
        }
        return sum;
    }

    function getFixedByteArrayAverage(bytes1[4] memory _data) external pure returns (uint8) {
        uint8 sum = 0;
        for (uint8 i = 0; i < _data.length; i++) {
            sum += uint8(_data[i]);
        }
        return sum / uint8(_data.length);
    }
}
