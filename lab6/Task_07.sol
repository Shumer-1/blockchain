// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_07 {
    address public owner;

    uint8 public constant COLORS_COUNT = 7;

    mapping(uint8 => string) private colors;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    constructor() {
        owner = msg.sender;

        colors[0] = "Red";
        colors[1] = "Orange";
        colors[2] = "Yellow";
        colors[3] = "Green";
        colors[4] = "Blue";
        colors[5] = "Indigo";
        colors[6] = "Violet";
    }

    function addColor(uint8 index, string calldata color) external {
        require(index < COLORS_COUNT, "Index out of range");
        colors[index] = color;
    }

    function getColor(uint8 index) external view returns (string memory) {
        require(index < COLORS_COUNT, "Index out of range");
        return colors[index];
    }

    function getAllColors() external view returns (string[] memory) {
        string[] memory result = new string[](COLORS_COUNT);
        for (uint8 i = 0; i < COLORS_COUNT; i++) {
            result[i] = colors[i];
        }
        return result;
    }

    function updateColor(uint8 index, string calldata newColor) external {
        require(index < COLORS_COUNT, "Index out of range");
        require(bytes(colors[index]).length > 0, "Color does not exist");
        colors[index] = newColor;
    }

    function colorExists(uint8 index) external view returns (bool) {
        require(index < COLORS_COUNT, "Index out of range");
        return bytes(colors[index]).length > 0;
    }

    function removeColor(uint8 index) external onlyOwner {
        require(index < COLORS_COUNT, "Index out of range");
        delete colors[index];
    }

    function replaceAllColors(string[] calldata newColors) external onlyOwner {
        require(newColors.length == COLORS_COUNT, "Must provide exactly 7 colors");

        for (uint8 i = 0; i < COLORS_COUNT; i++) {
            colors[i] = newColors[i];
        }
    }
}
