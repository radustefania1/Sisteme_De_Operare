#!/bin/bash
if [ $# -gt 0 ]
then echo  -e "Lista TBR:argument error" >&2
echo "usage:  lista TBR" >&2
exit  1
fi
BASE="$HOME/tbr.list"
while :
do
echo -e "
listaTBR=$BASE
MENIU
------------------------------
Adauga o carte in lista (a)
Sterge o carte din lista (s)
Editeaza lista(e)
Cauta o carte in lista(c)
Vizualizeaza lista de lecture completa (v)
<ENTER> exit program
Alegeti dintre: a/s/e/c/v sau <ENTER>:\c
------------------------------
"
read answ
case $answ in
"") exit 0;;
a|A) echo -e "Introduceti titlul cartii:\c"
read titlu
if [ $titlu = "" ]
then continue
fi
echo -e "Introduceti autorul cartii:\c"
read autor
echo -e "Introduceti numarul de pagini:\c"
read nrpag
echo -e "Introduceti editura:\c"
read editura
echo -e "$titlu\t\t$autor\t\t$editura\t\t$nrpag">>$BASE
sort -o $BASE $BASE
;;
s|S)
echo -e "Doriti sa stergeti dupa titlu(t) sau dupa numele autorului (a) (<ENTER> pentru a iesi)?:\c"
read stergere
case $stergere in
t|T) echo -e "Introduceti titlul cartii pe care doriti sa o scoateti din lista (<ENTER> pentru a iesi):\c"
read titlu
if [ $titlu = "" ]
then continue
fi
sed -e "/$titlu/d" $BASE > $BASE.new
mv $BASE.new $BASE;;
a|A) 
echo -e "Introduceti numele autorului care a scris cartea pe care doriti sa o scoateti din lista (<ENTER> pentru a iesi):\c"
read autor
if [ $autor = "" ]
then continue
fi
sed -e "/$autor/d" $BASE > $BASE.new
mv $BASE.new $BASE;;
*) echo "Comanda invalida! "
esac
e|E) pico $BASE;;
c|C) echo -e "\n Introduceti titlul pe care doriti sa il cautati:\c"
read titlu
grep -i $titlu $BASE > /dev/null
if [ "$?" -eq 0 ]
then
echo -e "\n--------------------"
grep -i $titlu $BASE
echo -e "\n--------------------"
else
echo "$titlu nu se afla in lista dvs TBR!!"
fi
;;
v|V) echo -e "\n\t Lista TBR\n\t-----------"
more $BASE
echo -e "\n Apasati <ENTER>\c"
read answ;;
*) echo -e "Comanda invalida!";;
esac
done
