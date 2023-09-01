#!/bin/bash
#IFS.OLD=$IFS
IFS=$'\n'
#IFS=$IFS.OLD
c=0
for line in ` cat list2.txt |awk '{print $1}'`
do
  account1=$line
  accounts1[$c]=$account1
  ((c++))
  mkdir -p  $line
done
d=0
for lines in ` cat list2.txt |awk '{print $2}'`
do
  account2=$lines
  accounts2[$d]=$account2
  ((d++))
done
e=0
for lines3 in ` cat list2.txt |awk '{print $3}'`
do
  account3=$lines3
  accounts3[$e]=$account3
  ((e++))
done

for((i=0;i<${#accounts2[@]};i++))
	do
		#echo ${#accounts2[@]}
		#echo ${accounts2[$i]};
		#echo ${accounts1[$i]};
		#sed  -i "s/${accounts2[$i]}/${accounts1[$i]}/g"  Hhprey.nwk;
		mv ${accounts2[$i]}  ${accounts1[$i]}/${accounts3[$i]};
	done
