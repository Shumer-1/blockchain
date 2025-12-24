// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_02 {
    uint[] public dynamicArray;
    uint[5] public fixedArray;

    function addToDynamicArray(uint _value) external {
        dynamicArray.push(_value);
    }

    function sumArray() public view returns (uint sum) {
        for (uint i = 0; i < dynamicArray.length; i++) {
            sum += dynamicArray[i];
        }
        return sum;
    }
}