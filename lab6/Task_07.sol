// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_07 {
    address public owner;

    uint256 private constant TEAM_SIZE = 3;

    mapping(uint256 => string) private roster;

    event AthleteSet(uint256 indexed index, string name);
    event AthleteCleared(uint256 indexed index);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier validIndex(uint256 index) {
        require(index < TEAM_SIZE, "Index out of range");
        _;
    }

    constructor() {
        owner = msg.sender;

        _set(0, "John Doe");
        _set(1, "Jane Smith");
        _set(2, "Mike Johnson");
    }

    // Внутренняя функция, чтобы не дублировать код установки
    function _set(uint256 index, string memory name) internal {
        roster[index] = name;
        emit AthleteSet(index, name);
    }

    // Добавить/установить спортсмена (public, memory)
    function addAthlete(uint256 index, string memory athlete) public validIndex(index) {
        _set(index, athlete);
    }

    // Обновить спортсмена (public, calldata)
    function updateAthlete(uint256 index, string calldata newName) public validIndex(index) {
        roster[index] = newName;
        emit AthleteSet(index, newName);
    }

    // Заменить всех спортсменов (только владелец)
    function replaceAllAthletes(string[] calldata names) external onlyOwner {
        require(names.length == TEAM_SIZE, "Need exactly 3 athletes");

        for (uint256 i = 0; i < TEAM_SIZE; i++) {
            roster[i] = names[i];
            emit AthleteSet(i, names[i]);
        }
    }

    // Получить спортсмена по индексу
    function getAthlete(uint256 index) external view validIndex(index) returns (string memory) {
        return roster[index];
    }

    // Проверить, есть ли спортсмен по индексу
    function athleteExists(uint256 index) external view validIndex(index) returns (bool) {
        return bytes(roster[index]).length != 0;
    }

    function removeAthlete(uint256 index) external onlyOwner validIndex(index) {
        delete roster[index];
        emit AthleteCleared(index);
    }

    function getAllAthletes() external view returns (string[] memory) {
        string[] memory out = new string[](TEAM_SIZE);

        for (uint256 i = 0; i < TEAM_SIZE; i++) {
            out[i] = roster[i];
        }

        return out;
    }
}
