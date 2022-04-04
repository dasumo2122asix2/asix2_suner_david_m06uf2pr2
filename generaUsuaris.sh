#!/bin/bash
#Script 8 de la pràctica 2
#David Suñer

clear

echo -n "Quantitat d'usuaris [1-100]: "
read quantitat
if [[ $quantitat -lt 1 ]] || [[ $quantitat -gt 100 ]]
then
	echo "Valor incorrecte. Ha d'estar entre 1 i 100"
	exit 1
fi

echo -n "Indica el valor inicial de l'uidNumber: "
read vin
vin=$((vin-1))

if [[ $vin < 5000 ]]
then
	echo "Numero incorrecte"
	exit 1
fi


if [[ -e nousUsuaris.ldif ]]
then
    rm nousUsuaris.ldif
fi

numberusr=$vin
for (( i=1; i<=$quantitat; i++))
do
	vin=$((vin+i))
	iduser=usr$numberusr

	echo "dn: uid=$iduser,cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" >> nousUsuaris.ldif
	echo "objectClass: top"  >> nousUsuaris.ldif
	echo "objectClass: person" >> nousUsuaris.ldif
	echo "objectClass: organizationalPerson" >> nousUsuaris.ldif
	echo "objectClass: inetOrgPerson" >> nousUsuaris.ldif
	echo "objectClass: posixAccount" >> nousUsuaris.ldif
	echo "objectClass: shadowAccount" >> nousUsuaris.ldif
	echo "cn: " $iduser >> nousUsuaris.ldif
	echo "sn: " $iduser >> nousUsuaris.ldif
	echo "uidNumber: " $numberusr >> nousUsuaris.ldif
	echo "gidNumber: 101" >> nousUsuaris.ldif
	echo "homeDirectory: /home/$iduser" >> nousUsuaris.ldif
	echo "loginShell: /bin/bash" >> nousUsuaris.ldif
	echo "objectClass: userPassword" >> ctsUsuaris.txt
	echo "" >> nousUsuaris.ldif
	((numberusr++))

done
ldapadd -h localhost -x -D "cn=admin,dc=fjeclot,dc=net" -W -f nousUsuaris.ldif

echo "Creació completada"
exit 0
