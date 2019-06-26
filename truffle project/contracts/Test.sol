pragma solidity ^0.5.0;

contract Test{
    string greet;
    uint number = 10;

    constructor() public {
        greet = "hello";
    }

    function getNumber() public view returns(string memory){
        string memory numero = _uint2str(number);
        return numero;
    }

    function getGreet() public view returns (string memory) {
        return greet;
    }
    function setGreet(string memory _newGreet) public {
        greet = _newGreet;
    }

    function _uint2str(uint _i) internal pure returns (string memory _uintAsString) {
    if (_i == 0) {
        return "0";
    }
    uint j = _i;
    uint len;
    while (j != 0) {
        len++;
        j /= 10;
    }
    bytes memory bstr = new bytes(len);
    uint k = len - 1;
    while (_i != 0) {
        bstr[k--] = byte(uint8(48 + _i % 10));
        _i /= 10;
    }
    return string(bstr);
    }

}