# -*-coding:Latin-1 -*
import os # On importe le module os
from random import *

nombre_aleatoire = randrange(101)

print("Devinez un nombre entre 1 et 100")
essai = int(input())

def comparaison(nombre, essai) :
	if essai < nombre  :
		if nombre-essai <= 5 :
			print("C'est un tout petit peu plus")
			
		elif nombre-essai < 10 :
			print("C'est un peu plus")
			
		else :
			print("C'est beaucoup plus")
			
	elif essai > nombre:
		if essai-nombre <= 5 :
			print("C'est un tout petit peu moins")
			
		elif essai-nombre < 10 :
			print("C'est un peu moins")
			
		else :
			print("C'est beaucoup moins")
	else :
		print("Vous avez gagne")		
	return	nombre-essai		

while comparaison(nombre_aleatoire,essai) != 0 :
	essai = int(input())

os.system("pause")