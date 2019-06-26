pragma solidity ^0.5.0;

import "./TazoBattle.sol";
import 'openzeppelin-solidity/contracts/token/ERC721/ERC721.sol';
import 'openzeppelin-solidity/contracts/math/SafeMath.sol';

contract TazoOwnership is TazoBattle, ERC721 {

    using SafeMath for uint256;

    mapping (uint => address) tazoApprovals;

    function balanceOf(address _owner) external view returns (uint256) {
        return ownerTazoCount[_owner];
    }

    function ownerOf(uint256 _tokenId) external view returns (address) {
        return tazoToOwner[_tokenId];
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        ownerTazoCount[_to] = ownerTazoCount[_to].add(1);
        ownerTazoCount[msg.sender] = ownerTazoCount[msg.sender].sub(1);
        tazoToOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
        require (tazoToOwner[_tokenId] == msg.sender || tazoApprovals[_tokenId] == msg.sender,
        "Usuário enviando o tazo precisar o dono do mesmo ou o receptor ter sido aprovado");
        _transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
        tazoApprovals[_tokenId] = _approved;
        emit Approval(msg.sender, _approved, _tokenId);
  }

}