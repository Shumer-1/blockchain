// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_03 {
    struct Person {
        string name;
        uint8 age;
    }

    Person[] public people;

    function addPerson(string memory _name, uint8 _age) external {
        people.push(Person(_name, _age));
    }

    function getUser(uint256 index) external view returns (string memory name, uint8 age) {
        require(index < people.length, "Index out of range");
        Person storage p = people[index];
        return (p.name, p.age);
    }
}
