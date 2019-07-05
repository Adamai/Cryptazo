pragma solidity ^0.5.0;

import 'openzeppelin-solidity/contracts/ownership/Ownable.sol';
import 'openzeppelin-solidity/contracts/math/SafeMath.sol';

contract TazoFactory is Ownable {

    using SafeMath for uint256;

    event NewTazo(uint tazoId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    struct Tazo {
        string name;
        uint dna;
        uint level;
        uint cooldown;
        uint winCount;
        bool forSale;
        uint price;
    }

    Tazo[] public tazos;

    mapping(uint => address) public tazoToOwner;        //mapeamento de tazo para dono
    mapping(address => uint) public ownerTazoCount;     //mapeamento de dono para quantidade de tazos

    function _createTazo(string memory _name, uint _dna) internal returns(uint){
        uint id = tazos.push(Tazo(_name, _dna, 1, uint32(now + cooldownTime), 0, false, 0)) - 1;
        tazoToOwner[id] = msg.sender;
        ownerTazoCount[msg.sender] = ownerTazoCount[msg.sender].add(1);
        emit NewTazo(id, _name, _dna);
        return id;
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomTazo(string memory _name) public {
        require(ownerTazoCount[msg.sender] == 0, "Somente novos usuários sem tazos podem gerar um tazo");
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100;
        _createTazo(_name, randDna);
  }

}