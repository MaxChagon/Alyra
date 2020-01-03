function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
}

var nombre_aleatoire = getRandomInt(101)
var message = "Devinez un nombre entre 1 et 100 "
var essai1 = 0

var comparaison = function(nombre,essai){
    if(essai < nombre){
	if(nombre-essai <= 5){
	    message="C'est un tout petit peu plus "
	}else if(nombre-essai < 10){
	    message="C'est un peu plus "
	}else{
	    message="C'est beaucoup plus "
	}
    }else if(essai > nombre){
	if(essai-nombre <= 5){
	    message="C'est un tout petit peu moins "
	}else if(essai-nombre < 10){
	    message="C'est un peu moins "
	}else{
	    message="C'est beaucoup moins "
	}
    }else{
	message="Vous avez gagne "
    }
    return nombre-essai
}
    
var readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var jeu = function(nombre,essai){
    if(comparaison(nombre,essai) != 0){
	rl.question(message, (answer)=> {
	    essai1=answer
	    jeu(nombre,answer)
	});
    }else{
	console.log(message)
	rl.close();	
    }
}

rl.question(message, (answer) => {
    jeu(nombre_aleatoire,answer)
});
