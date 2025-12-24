// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_05 {
    int256[] public celsiusTemps;

    function setCelsiusTemps(int256[] calldata temps) external {
        delete celsiusTemps;
        for (uint256 i = 0; i < temps.length; i++) {
            celsiusTemps.push(temps[i]);
        }
    }

    function addCelsiusTemp(int256 temp) external {
        celsiusTemps.push(temp);
    }

    function getAllTempsInFahrenheit() external view returns (int256[] memory) {
        int256[] memory result = new int256[](celsiusTemps.length);

        for (uint256 i = 0; i < celsiusTemps.length; i++) {
            result[i] = _toFahrenheit(celsiusTemps[i]);
        }

        return result;
    }

    function convertArrayToFahrenheit(int256[] calldata temps) external pure returns (int256[] memory) {
        int256[] memory result = new int256[](temps.length);

        for (uint256 i = 0; i < temps.length; i++) {
            result[i] = _toFahrenheit(temps[i]);
        }

        return result;
    }

    function _toFahrenheit(int256 c) private pure returns (int256) {
        return (c * 9) / 5 + 32;
    }
}
