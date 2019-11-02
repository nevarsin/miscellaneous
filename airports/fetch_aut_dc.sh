#!/bin/bash
#Get Automattic Datacenter city names
#Stefano Chittaro (Italy) Nov 2nd 2019

#Set newline char as the only for loop separator
IFS=$'\n' 

#Fetch airport codes from automattic.com and loop through them
for i in $(curl -s https://ac-map.automattic.com | grep 'dcss\["') 
do
	AIRPORT=$(echo $i |cut -f 2 -d '"')
	COLOR=$(echo $i |cut -f 2 -d# | awk -F ' ' '{print $2}')
	
	#Ask a third party site for city match against airport code
	CITY_NAME=$(curl -s 'http://www.webflyer.com/travel/milemarker/getmileage_ft.cgi?city='$AIRPORT|grep '</CENTER>'|awk -F '<' '{print $1}'|xargs)
	
	#Manage undefined case
	if [ $AIRPORT == 'UND' ]
	then
		CITY_NAME='UNDEFINED'	
	fi	
	
	#print output
	echo $CITY_NAME";"$COLOR	
done