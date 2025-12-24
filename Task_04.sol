// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_04 {
    mapping(address => uint256) public balances;

    function setBalance(address _addr, uint256 _balance) external {
        balances[_addr] = _balance;
    }

    function getBalance(address _addr) external view returns (uint256) {
        return balances[_addr];
    }
}
