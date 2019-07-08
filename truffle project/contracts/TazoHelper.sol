pragma solidity ^0.5.0;

import "./TazoFuse.sol";
import 'openzeppelin-solidity/contracts/ownership/Ownable.sol';
//import 'github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol';

contract TazoHelper is TazoFuse {
    uint levelUpFee = 0.0001 ether;

    modifier aboveLevel(uint _level, uint _tazoId) {
    require(tazos[_tazoId].level >= _level, string(abi.encodePacked("O level do tazo precisa ser maior que ", _level)));
    _;
  }

    function setLevelUpFee(uint _fee) external onlyOwner {
        levelUpFee = _fee;
    }

    function getLevelUpFee() external view returns(uint){
      return levelUpFee;
    }

    function levelUp(uint _tazoId) external payable {
        require(msg.value == levelUpFee, string(abi.encodePacked("O valor pago precisa ser igual a taxa de ", levelUpFee)));
        tazos[_tazoId].level = tazos[_tazoId].level.add(1);
    }

    function changeName(uint _tazoId, string calldata _newName) external onlyOwnerOf(_tazoId) {
        tazos[_tazoId].name = _newName;
    }

    function getTazosByOwner(address _owner) external view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerTazoCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < tazos.length; i++) {
      if (tazoToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
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

  /* function getTazos() public view returns(string memory) {
    uint[] memory result = new uint[](tazos.length);
    uint counter = 0;
    for (uint i = 0; i < tazos.length; i++) {
        result[counter] = i;
        counter++;
    }
    return _uint2str(tazos.length);
  } */

}