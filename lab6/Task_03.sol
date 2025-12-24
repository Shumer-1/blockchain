// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_03 {
    function generateFactorial(uint256 n) external pure returns (uint256) {
        uint256 result = 1;
        uint256 i = 1;

        while (i <= n) {
            result *= i;
            i++;
        }

        return result;
    }
}
