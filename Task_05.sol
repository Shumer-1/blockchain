// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_05 {
    enum Status {
        Pending,
        Active,
        Inactive
    }

    Status public currentStatus;

    function setStatus(Status _status) external {
        currentStatus = _status;
    }

    function getBalance() external view returns (uint256) {
        return uint256(currentStatus);
    }
}
