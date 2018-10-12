#!/bin/bash
liste=liste.txt.utf8

###################
#### FONCTIONS ####
###################

# Choisi un mot aléatoirement dans le fichier liste.txt
motAuHasard () {  
  nbLignes=$(wc -l $liste | cut -f1 -d" ")
  #ligneAleat=$(( $((RANDOM %580)) * $((RANDOM %580)) ))
  ligneAleat=$(shuf -i 0-$nbLignes -n 1)
  echo $(head -$ligneAleat $liste | tail -1)
}
motCache=$(motAuHasard)
listeLettresCachees=azertyuiopqsdfghjklmwxcvbn



# Affiche le mot en remplacant les lettre non trouvées par des _
afficheMot () {
  echo $1 | tr $2 '_'
}


# Supprimer un caractère trouvé de la liste des caractères non trouvés
decouvre () {
  listeLettresCachees=$(echo $listeLettresCachees | tr -d $1)
}


# Test si le mot contient des caractères cachés
testGagne (){
  test=$(afficheMot $1 $2 | sed 's/[^_]*//g')
  if [ -z "$test" ] ##ERREUR
   then
     # Le mot caché ne contient plus de caractère caché
    echo 0
   else
     # Le mot caché contient des caractères cachés
    echo 1
  fi
}


affichePendu() {
  case $1 in
	0)
		echo
	;;
 	1)
		echo " |"
		echo " |"
		echo " |"
		echo " |"
		echo " |"
	;;
	2)
		echo " ______"
		echo " |"
		echo " |"
		echo " |"
		echo " |"
		echo " |"
	;;
	3)
		echo " ______"
		echo " |/"
		echo " |"
		echo " |"
		echo " |"
		echo " |"
	;;
	4)
		echo " ______"
		echo " |/"
		echo " |"
		echo " |"
		echo " |"
		echo "_|_"
	;;
	5)
		echo " ______"
		echo " |/  |"
		echo " |"
		echo " |"
		echo " |"
		echo "_|_"
	;;
	6)
		echo " ______"
		echo " |/  |"
		echo " |   o"
		echo " |"
		echo " |"
		echo "_|_"
	;;
	7)
		echo " ______"
		echo " |/  |"
		echo " |   o"
		echo " |   O"
		echo " |"
		echo "_|_"
	;;
	8)
		echo " ______"
		echo " |/  |"
		echo " |  \o"
		echo " |   O"
		echo " |"
		echo "_|_"
	;;
	9)
		echo " ______"
		echo " |/  |"
		echo " |  \o/"
		echo " |   O"
		echo " |"
		echo "_|_"
	;;
	10)
		echo " ______"
		echo " |/  |"
		echo " |  \o/"
		echo " |   O"
		echo " |  /"
		echo "_|_"
	;;
	*)
		echo " ______"
		echo " |/  |"
		echo " |  \o/"
		echo " |   O"
		echo " |  / \\"
		echo "_|_   "
		echo
		echo
		echo "############################"
		echo "    Vous avez perduuuu !"
		echo "############################"
		echo "Le mot était : $motCache"
		echo "perdu ; $player ; $motCache" >> scores.txt

		exit
	;;
  esac
}

testPresence () {
	if [ $1 = "$(echo $1 | grep $2)" ]
	  then
	    echo 0
	  else
	    echo 1
	fi
}

#Remplace les accents dans les mots
motCache=$(echo $motCache | sed 'y/áàâäçéèêëîïìôöóùúüñÂÀÄÇÉÈÊËÎÏÔÖÙÜÑ/aaaaceeeeiiiooouuunAAACEEEEIIOOUUN/')
tour=0
fautes=0

echo "Saisir votre nom :"
read player

while [ $(testGagne $motCache $listeLettresCachees) = 1 ]
do
	clear
	#echo "MotCache: $motCache"
	echo "###################"
	echo "     Tour n°$tour :"
	echo "###################"
	echo
	affichePendu $fautes
	echo
	echo "Mot :"
	afficheMot $motCache $listeLettresCachees
	echo
	echo "Lettre à découvrir :"
	read lettre
	lettre=$(echo $lettre | cut -c1)
	
	if [ $(testPresence $motCache $lettre) = 1 ]
	  then
	    fautes=$(expr $fautes + 1)
	  else
	    decouvre $lettre
	fi
	
	tour=$(expr $tour + 1)
done
clear
echo "############################"
echo "     Vous avez gagneuh"
echo "############################"
echo "Le mot était : $motCache"
echo "Vous avez fait $fautes faute(s)"

echo "$fautes ; $player ; $motCache" >> scores.txt







