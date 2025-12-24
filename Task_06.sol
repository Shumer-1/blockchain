// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_06 {
    uint256 public constant MAX_UINT = type(uint256).max;
    uint8 public constant MAX_UINT8 = type(uint8).max;

    function getMaxUint256() external pure returns (uint256) {
        return MAX_UINT;
    }

    function getMaxUint8() external pure returns (uint8) {
        return MAX_UINT8;
    }
}
