pragma solidity ^0.4.25;

contract Test{
    string greet = "Hello";
    
    function getGreet() view returns (string) {
        return greet;
    }
    
    function setGreet(string _newGreet){
        greet = _newGreet;    
    }
    
}