pragma solidity ^0.5.0;

import "./TazoFuse.sol";

contract TazoHelper is TazoFuse {
    uint levelUpFee = 0.0001 ether;

    modifier aboveLevel(uint _level, uint _tazoId) {
    require(tazos_tazoId].level >= _level);
    _;
  }

    function setLevelUpFee(uint _fee) external onlyOwner {
        levelUpFee = _fee;
    }

    function levelUp(uint _tazoId) external payable {
        require(msg.value == levelUpFee);
        tazos[_tazoId].level = tazos[_tazoId].level.add(1);
    }

    function changeName(uint _tazoId, string _newName) external onlyOwnerOf(_tazoId) {
        tazos[_tazoId].name = _newName;
    }

    function getTazosByOwner(address _owner) external view returns(uint[]) {
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

}