pragma solidity ^0.5.12;
pragma experimental ABIEncoderV2;

import "./safemath.sol";

 /**
 * @title CanalDepaiement
 * @dev canal de paiement entre partieA et partieB
 */

contract CanalDePaiement{
 
 enum EtatCanal { VIDE, ACTIF, ENCOURSFERMETURE, FERME }
 address partieA;
 address partieB;
 uint montant;
 EtatCanal etat;
 uint blocFermeture; 
 uint dernierNonce;
 uint equilibreA;
 uint equilibreB;
    
 constructor(uint _montant, address _partieA, address _partieB) public{
     partieA = _partieA;
     partieB = _partieB;
     montant = _montant;
     etat = EtatCanal.VIDE;
 }    
 
 function financer() public payable{
     require(msg.sender == partieA || msg.sender == partieB);
     require(msg.value == montant);
     if(msg.sender == partieA){
         equilibreA = montant;
     }else{
         equilibreB = montant;
     }
     
     if(equilibreA == montant && equilibreB == montant){
         etat = EtatCanal.ACTIF;
     }
 }

        
}
