pragma solidity ^0.5.12;


contract ObjetMagique{
    
    uint256 id;
    
    constructor(uint rarete, uint typeObjet, uint modele) public {
        id = rarete;
        id *= 10;
        id += typeObjet;
        id *= 100;
        id += modele;
    }
}

contract ObjetsMagiques{
    
    mapping (uint256 => address) public possesseurs;
    
    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);

    function balanceOf(address _owner) public view returns (uint256 balance){
        return _owner.balance;
    }
    
    function ownerOf(uint256 _tokenId) public view returns (address _owner){
        address retour = possesseurs[_tokenId];
        return retour;
    }
    
    function exists(uint256 _tokenId) public view returns (bool _exists){
        return (possesseurs[_tokenId] != address(0));
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        require(_from != address(0));
        require(_to != address(0));
        require(possesseurs[_tokenId] == _from);
        possesseurs[_tokenId] = _to;
    }
    
    
    
    
}
