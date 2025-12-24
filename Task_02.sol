// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Task_02 {
   uint[] public dynamicArray;
   uint[5] public fixedArray;


   function addToDynamicArray(uint _value) external {
       dynamicArray.push(_value);
   }

   function sumArray() external view returns (uint sum) {
        uint len = dynamicArray.length;
        for (uint i = 0; i < len; i++) {
            sum += dynamicArray[i];
        }
    }
}