pragma solidity ^0.5.12;


contract ObjetMagique{
    
    uint256 id;
    
    constructor(uint rarete, uint typeObjet, uint pouvoir, uint modele) public {
        id = rarete;
        id *= 10;
        id += typeObjet;
        id *= 10;
        id += pouvoir;
        id *= 10;
        id += modele;
    }
    
    function getId() public view returns (uint256){
        return id;
    }
}


contract Bazar{
    
    struct enchere {
     address meilleurAcheteur;
     uint256 meilleureOffre;
     uint256 finEnchere;
     uint256 objet;
     address vendeur;
   }
   
   ObjetsMagiques objMag = new ObjetsMagiques();
   
   uint numEnchere;
   mapping (uint => enchere) Encheres;
   mapping (address => uint) Remboursements;
   
   function proposerALaVente(uint256 objet) public{
        require(objMag.ownerOf(objet) == address(this));
        uint numero = numEnchere++;
        uint fin = block.number;
        Encheres[numero] = enchere(address(0),0,uint256(fin)+1000,objet,msg.sender);
    }
    
    function offre(uint indice) public payable{
        require(Encheres[indice].finEnchere > block.number);
        if(msg.value > Encheres[indice].meilleureOffre){
            Remboursements[Encheres[indice].meilleurAcheteur] = Encheres[indice].meilleureOffre;
            Encheres[indice].meilleureOffre = msg.value;
            Encheres[indice].meilleurAcheteur = msg.sender;
        }
    }
    
    function remboursement() public {
        require(Remboursements[msg.sender] != 0);
        msg.sender.transfer(Remboursements[msg.sender]);
    }
    
    function recupererObjet(uint indice) public {
        require(Encheres[indice].finEnchere < block.number);
        if(Encheres[indice].meilleurAcheteur == msg.sender){
            objMag.accessPoss(indice, msg.sender);
        }
        else if(Encheres[indice].meilleurAcheteur == address(0)){
            require(msg.sender == Encheres[indice].vendeur);
            objMag.accessPoss(indice, msg.sender);
        }
    }
}

contract ObjetsMagiques{
    
    mapping (uint256 => address) public possesseurs;
    mapping (uint256 => bool) public existence;
    
    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);

    function accessPoss(uint256 obj, address poss) public {
        possesseurs[obj] = poss;
    }

    function balanceOf(address _owner) public view returns (uint256 balance){
        return _owner.balance;
    }
    
    function ownerOf(uint256 _tokenId) public view returns (address _owner){
        address retour = possesseurs[_tokenId];
        return retour;
    }
    
    function exists(uint256 _tokenId) public view returns (bool _exists){
        return existence[_tokenId];
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        require(_from != address(0));
        require(_to != address(0));
        require(_tokenId/100 != 2); //les objets divins ne sont pas transferables
        require(possesseurs[_tokenId] == _from);
        possesseurs[_tokenId] = _to;
    }
    
    
    function creuser() public payable returns (ObjetMagique){
        require(msg.value == 1e17);
        uint rarete = uint8(blockhash(block.number-1)[0])%3;
        uint typeObjet = uint8(blockhash(block.number-1)[1])%3;
        uint pouvoir = uint8(blockhash(block.number-1)[2])%3;
        uint modele = uint8(blockhash(block.number-1)[3])%3;
        ObjetMagique nouvelObjet = new ObjetMagique(rarete,typeObjet,pouvoir,modele);
        if (existence[nouvelObjet.getId()] == true){
            nouvelObjet = creuser();
        }
        else{
            existence[nouvelObjet.getId()] = true;
        }
        return nouvelObjet;
    }
    
    function utiliser(uint256 _tokenId) public returns (uint){
        require(possesseurs[_tokenId] == msg.sender);
        uint resultat = uint8(blockhash(block.number-1)[0])%11;
        if(resultat == 0){
            existence[_tokenId] = false;
            possesseurs[_tokenId] = address(0);
        }
        return resultat;
    }
    
    
    
}
