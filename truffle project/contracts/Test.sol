pragma solidity ^0.5.0;

contract Test{
    string greet;

    constructor() public {
        greet = "hello";
    }

    function getGreet() public view returns (string memory) {
        return greet;
    }
    function setGreet(string memory _newGreet) public {
        greet = _newGreet;
    }
}