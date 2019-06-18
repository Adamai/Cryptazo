pragma solidity ^0.4.25;

contract Test{
    string greet;

    constructor() public {
        greet = "hello";
    }

    function getGreet() public view returns (string) {
        return greet;
    }
    function setGreet(string _newGreet) public {
        greet = _newGreet;
    }
}