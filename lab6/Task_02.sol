// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_02 {
    function generateSquares(uint256 n) external pure returns (uint256[] memory) {
        uint256[] memory squares = new uint256[](n);

        for (uint256 i = 1; i <= n; i++) {
            squares[i - 1] = i * i;
        }

        return squares;
    }
}
