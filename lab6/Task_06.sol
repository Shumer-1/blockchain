// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_06 {
    address public owner;

    mapping(uint8 => string) private colors;
    uint8 public constant COLORS_COUNT = 7;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    constructor() {
        owner = msg.sender;

        string[] memory defaults = new string[](COLORS_COUNT);
        defaults[0] = "Red";
        defaults[1] = "Orange";
        defaults[2] = "Yellow";
        defaults[3] = "Green";
        defaults[4] = "Blue";
        defaults[5] = "Indigo";
        defaults[6] = "Violet";

        for (uint8 i = 0; i < COLORS_COUNT; i++) {
            colors[i] = defaults[i];
        }
    }

    function addColor(uint8 index, string memory color) public {
        require(index < COLORS_COUNT, "Index out of range");
        colors[index] = color;
    }

    function getColor(uint8 index) public view returns (string memory) {
        require(index < COLORS_COUNT, "Index out of range");
        return colors[index];
    }

    function colorExists(uint8 index) public view returns (bool) {
        require(index < COLORS_COUNT, "Index out of range");
        return bytes(colors[index]).length > 0;
    }

    function removeColor(uint8 index) public onlyOwner {
        require(index < COLORS_COUNT, "Index out of range");
        delete colors[index];
    }

    function getAllColors() public view returns (string[] memory) {
        string[] memory result = new string[](COLORS_COUNT);

        for (uint8 i = 0; i < COLORS_COUNT; i++) {
            result[i] = colors[i];
        }

        return result;
    }
}
