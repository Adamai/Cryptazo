pragma solidity ^0.5.0;

import "./TazoBattle.sol";
import 'openzeppelin-solidity/contracts/token/ERC721/ERC721.sol';
import 'openzeppelin-solidity/contracts/math/SafeMath.sol';

contract TazoOwnership is TazoBattle, ERC721 {

    using SafeMath for uint256;

    mapping (uint => address) tazoApprovals;

    function balanceOf(address _owner) public view returns (uint256) {
        return ownerTazoCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address) {
        return tazoToOwner[_tokenId];
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        ownerTazoCount[_to] = ownerTazoCount[_to].add(1);
        ownerTazoCount[msg.sender] = ownerTazoCount[msg.sender].sub(1);
        tazoToOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        require (tazoToOwner[_tokenId] == msg.sender || tazoApprovals[_tokenId] == msg.sender,
        "Usuário enviando o tazo precisar o dono do mesmo ou o receptor ter sido aprovado");
        _transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        tazoApprovals[_tokenId] = _approved;
        emit Approval(msg.sender, _approved, _tokenId);
  }

    function getContractBalance() public view onlyOwner returns(uint) {
        return address(this).balance;
    }

    function transferEthToOwner() external onlyOwner returns(uint) {
        uint actualMoney = address(this).balance;
        msg.sender.transfer(address(this).balance);
        return actualMoney;
    }

    function putTazoForSale(uint _tazoId, uint _price) external onlyOwnerOf(_tazoId) {
        require(_price > 0, 'Preço de venda do tazo deve ser maior que 0');
        Tazo storage myTazo = tazos[_tazoId];
        myTazo.forSale = true;
        myTazo.price = _price;
    }

    function cancelTazoSale(uint _tazoId) external onlyOwnerOf(_tazoId) {
        Tazo storage myTazo = tazos[_tazoId];
        myTazo.forSale = false;
        myTazo.price = 0;
    }

    function purchaseTazo(uint _tazoId) external payable returns(bool) {
        Tazo storage tazo = tazos[_tazoId];
        address _ogOwner = tazoToOwner[_tazoId];
        require(tazo.price == msg.value && tazo.forSale, 'Valor pago precisa ser igual ao preço do tazo');
        tazo.forSale = false;
        tazo.price = 0;
        emit Approval(_ogOwner, msg.sender, _tazoId);
        ownerTazoCount[msg.sender] = ownerTazoCount[msg.sender].add(1);
        ownerTazoCount[_ogOwner] = ownerTazoCount[_ogOwner].sub(1);
        tazoToOwner[_tazoId] = msg.sender;
        emit Transfer(_ogOwner, msg.sender, _tazoId);
        return true;
    }

}