pragma solidity ^0.5.0;

import "./TazoFactory.sol";

contract TazoFuse is TazoFactory {

    modifier onlyOwnerOf(uint _TazoId) {
        require(msg.sender == tazoToOwner[_TazoId], 'Somente o dono do tazo pode realizar alteração');
        _;
    }

    function _triggerCooldown(Tazo storage _tazo) internal {
     _tazo.cooldown = uint(now + cooldownTime);
  }

  function _isReady(Tazo storage _tazo) internal view returns (bool)
{
    return (_tazo.cooldown <= now);
}
    function tazoFusion(uint _tazoId1, uint _tazoId2) internal onlyOwnerOf(_tazoId1) onlyOwnerOf(_tazoId2){
        Tazo storage myTazo1 = tazos[_tazoId1];
        Tazo storage myTazo2 = tazos[_tazoId2];

        uint newDna = uint(myTazo1.dna + myTazo2.dna)/2;
        uint newId = _createTazo("no name", newDna);
        _triggerCooldown(tazos[newId]);
    }
}