# -*-coding:Latin-1 -*
import os # On importe le module os
from random import *

nombre_aleatoire = randrange(101)

print("Devinez un nombre entre 1 et 100")
essai = int(input())

def comparaison(nombre, essai) :
	if essai < nombre_aleatoire  :
		if nombre_aleatoire-essai <= 5 :
			print("C'est un tout petit peu plus")
			
		elif nombre_aleatoire-essai < 10 :
			print("C'est un peu plus")
			
		else :
			print("C'est beaucoup plus")
			
	elif essai > nombre_aleatoire:
		if essai-nombre_aleatoire <= 5 :
			print("C'est un tout petit peu moins")
			
		elif essai-nombre_aleatoire < 10 :
			print("C'est un peu moins")
			
		else :
			print("C'est beaucoup moins")
	else :
		print("Vous avez gagne")		
	return	nombre-essai		

while comparaison(nombre_aleatoire,essai) != 0 :
	essai = int(input())

os.system("pause")