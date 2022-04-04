#!/bin/bash
#Script 5 de la pràctica 2
#David Suñer
case $1 in 
  -e) if (( $# != 3 )) 
      then
        echo "L'opció -e necessita 2 paràmetres addicionals, la extensió de l'arxiu i el directori."
        exit 2
      fi
      if [[ ! -d ~/paperera ]]
      then
        mkdir ~/paperera
      fi
      if [[ ! -d $3 ]]
      then
        echo "La carpeta indicada no existeix"
      else
        if (( $(ls -A $3/*.$2 | wc -l) != 0 ))
        then
          mv $3/*.$2 ~/paperera
          echo "Els fitxers amb extensió $2 de la carpeta $3 s'han enviat a la paperera"
        else
          echo "Els fitxers amb l'extensió indicada no existeixen"
        fi
      fi		 
	 ;;
  -r) if (( $# != 1 )) 
    then
      echo "Paràmetres incorrecte"
      exit 1
    fi
    if [[ ! -d ~/paperera ]]
    then
      echo "La paperera encara no existeix"
    else
      if (( $(ls -A ~/paperera | wc -l) != 0 ))
      then
        rm ~/paperera/* 
        echo "Paperera buida"
      fi
    fi
    ;;
    	*) 
    	 echo "Parametre incorrecte"
	    exit 3
	    ;;
esac
exit 0
