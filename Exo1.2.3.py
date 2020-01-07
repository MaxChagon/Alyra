import os 

def impairsInf(nombre):
	result=1
	for x in range(nombre+1):
		if x%2==1:
			result*=x
	return result


def factorielle(nombre):
	if nombre >= 2 :
		return impairsInf(nombre)*factorielle(int(nombre/2))*2*(2**(int(nombre/2)-1))
	else:
		return 1

print("Rentrez un nombre")
nombre=int(input())
print("factorielle(",nombre,") = ",factorielle(nombre))

os.system("pause")