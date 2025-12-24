// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_11 {
    enum State {
        Active,
        Paused,
        Closed
    }

    address public owner;
    uint256 public immutable goal;
    uint256 public totalRaised;
    State public state; 

    mapping(address => uint256) public deposits;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    modifier inState(State s) {
        require(state == s, "Invalid state");
        _;
    }

    event Deposited(address indexed from, uint256 amount, uint256 totalRaised);
    event Refunded(address indexed to, uint256 amount, uint256 totalRaised);
    event OwnerWithdrewOwn(uint256 amount, uint256 totalRaised);
    event OwnerWithdrewAll(uint256 amount);
    event StateChanged(State newState);

    constructor(uint256 _goal) payable {
        require(_goal > 0, "Goal must be > 0");
        owner = msg.sender;
        goal = _goal;

        state = State.Active;

        if (msg.value > 0) {
            deposits[owner] += msg.value;
            totalRaised += msg.value;
            emit Deposited(owner, msg.value, totalRaised);

            if (totalRaised >= goal) {
                state = State.Closed;
                emit StateChanged(state);
            }
        }
    }

    function deposit() external payable inState(State.Active) {
        require(msg.value > 0, "Zero deposit");

        deposits[msg.sender] += msg.value;
        totalRaised += msg.value;

        emit Deposited(msg.sender, msg.value, totalRaised);

        if (totalRaised >= goal) {
            state = State.Closed;
            emit StateChanged(state);
        }
    }

    function pause() external onlyOwner inState(State.Active) {
        state = State.Paused;
        emit StateChanged(state);
    }

    function resume() external onlyOwner inState(State.Paused) {
        state = State.Active;
        emit StateChanged(state);
    }

    function refund() external inState(State.Paused) {
        uint256 amount = deposits[msg.sender];
        require(amount > 0, "Nothing to refund");

        deposits[msg.sender] = 0;
        totalRaised -= amount;

        (bool ok, ) = payable(msg.sender).call{value: amount}("");
        require(ok, "Refund failed");

        emit Refunded(msg.sender, amount, totalRaised);
    }

    function ownerWithdrawOwnDeposit() external onlyOwner {
        require(state == State.Active || state == State.Paused, "Not allowed now");

        uint256 amount = deposits[owner];
        require(amount > 0, "Owner has no deposit");

        deposits[owner] = 0;
        totalRaised -= amount;

        (bool ok, ) = payable(owner).call{value: amount}("");
        require(ok, "Withdraw failed");

        emit OwnerWithdrewOwn(amount, totalRaised);
    }

    function ownerWithdrawAll() external onlyOwner inState(State.Closed) {
        uint256 amount = address(this).balance;
        require(amount > 0, "Nothing to withdraw");

        (bool ok, ) = payable(owner).call{value: amount}("");
        require(ok, "Withdraw failed");

        emit OwnerWithdrewAll(amount);
    }

    function contractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
