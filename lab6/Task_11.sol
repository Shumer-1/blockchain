// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_11 {
    enum Status { Active, Paused, Closed }

    address public owner;
    Status public status;

    uint256 public immutable targetAmount;
    uint256 public totalUserDeposits;

    mapping(address => uint256) public deposits;

    event Deposited(address indexed user, uint256 amount, uint256 totalDeposits);
    event Withdrawn(address indexed user, uint256 amount, uint256 totalDeposits);
    event StatusChanged(Status newStatus);
    event Closed(uint256 totalDeposits);
    event OwnerWithdrawn(uint256 amount);

    constructor(uint256 _targetAmount) {
        require(_targetAmount > 0, "Target must be > 0");
        owner = msg.sender;
        targetAmount = _targetAmount;
        status = Status.Active;
        emit StatusChanged(status);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    modifier whenClosed() {
        require(status == Status.Closed, "Contract is not closed");
        _;
    }

    function pause() external onlyOwner {
        require(status == Status.Active, "Not active");
        status = Status.Paused;
        emit StatusChanged(status);
    }

    function resume() external onlyOwner {
        require(status == Status.Paused, "Not paused");
        status = Status.Active;
        emit StatusChanged(status);
    }

    function deposit() external payable {
        require(status == Status.Active, "Deposits disabled");
        require(msg.value > 0, "Deposit must be > 0");

        deposits[msg.sender] += msg.value;
        totalUserDeposits += msg.value;

        emit Deposited(msg.sender, msg.value, totalUserDeposits);

        if (totalUserDeposits >= targetAmount) {
            status = Status.Closed;
            emit StatusChanged(status);
            emit Closed(totalUserDeposits);
        }
    }

    function withdraw() external {
        require(status == Status.Paused, "Withdrawals allowed only when paused");

        uint256 amount = deposits[msg.sender];
        require(amount > 0, "Nothing to withdraw");

        deposits[msg.sender] = 0;
        totalUserDeposits -= amount;

        (bool ok, ) = payable(msg.sender).call{value: amount}("");
        require(ok, "Transfer failed");

        emit Withdrawn(msg.sender, amount, totalUserDeposits);
    }

    function ownerWithdraw() external onlyOwner {
        if (status == Status.Closed) {
            uint256 amount = address(this).balance;
            require(amount > 0, "Nothing to withdraw");

            (bool ok, ) = payable(owner).call{value: amount}("");
            require(ok, "Transfer failed");

            emit OwnerWithdrawn(amount);
            return;
        }

        uint256 amountOwn = deposits[owner];
        require(amountOwn > 0, "No owner deposit");

        deposits[owner] = 0;
        totalUserDeposits -= amountOwn;

        (bool ok2, ) = payable(owner).call{value: amountOwn}("");
        require(ok2, "Transfer failed");

        emit OwnerWithdrawn(amountOwn);
    }

    receive() external payable {
        revert("Use deposit()");
    }
}