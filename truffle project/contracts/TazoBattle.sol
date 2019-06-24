pragma solidity ^0.5.0;

import "./TazoHelper.sol";

contract TazoBattle is TazoHelper {

    uint randNonce = 0;

    function getTazoPower(uint _tazoId) public returns(uint){
        uint tazoDna = tazos[_tazoId].dna;
        uint basePower = tazoDna%10000;
        return ((basePower%5)+1) * tazos[_tazoId].level;
    }


  function randMod(uint _modulus) internal returns(uint) {
    randNonce = randNonce.add(1);
    return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;
  }

  function attack(uint _tazoId, uint _targetId) external onlyOwnerOf(_tazoId) {
    Tazo storage myTazo = tazos[_tazoId];
    Tazo storage enemyTazo = tazos[_targetId];
    uint rand = randMod(100);
    uint battleVictoryProbability;
    uint levelGain;
    uint levelDifference = myTazo.level - enemyTazo.level;
    if(levelDifference <= -8){
        battleVictoryProbability = 7;
        levelGain = 12;
    }
    else if(levelDifference <= -5 && levelDifference > -8){
        battleVictoryProbability = 14;
        levelGain = 9;
    }
    else if(levelDifference < 0 && levelDifference > -5){
        battleVictoryProbability = 20;
        levelGain = 7;
    }
    else if(0 < levelDifference && levelDifference < 5){
        battleVictoryProbability = 60;
        levelGain = 4
    }
    else if(5 <= levelDifference && levelDifference < 8){
        battleVictoryProbability = 70;
        levelGain = 3;
    }
    else if(8 <= levelDifference && levelDifference < 10){
        battleVictoryProbability = 80;
        levelGain = 2;
    }
    else if(levelDifference >= 10){
        battleVictoryProbability = 85;
        levelGain = 1;
    }
    else if(levelDifference == 0){
        battleVictoryProbability = 50;
        levelGain = 4;
    }

    if (rand <= battleVictoryProbability) {
      myTazo.winCount = myTazo.winCount.add(1);
      myTazo.level = myTazo.level.add(levelGain);
    } else {
      enemyTazo.winCount = enemyTazo.winCount.add(1);
      enemyTazo.level = enemyTazo.level.add(1);
    }
    _triggerCooldown(myTazo);
  }

}