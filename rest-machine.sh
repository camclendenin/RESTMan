#!/bin/bash

config=RestMachineConfig.h
echo $config
declare -a resources
declare -a resoucePathNames
declare -a resouceVarNames
BASE_URL=""
echo "#import <Foundation/Foundation.h>" > $config
echo "" >> $config
echo "typedef enum {" >> $config
echo "    NONE," >> $config
# get user-defined resources from plist
echo "RestMachine has started..."
echo "Adding support for..."
while read line           
do           
    #echo $line           
    str=${line/<string>/}
    resource=${str/<*/}
    if [ "${#resource}" -gt 0 ]; then
        if [ -z "$BASE_URL" ]
        then
            BASE_URL=$resource
            echo "base url : $resource"
	    continue
        fi
       
      	p1=${resource//#*/}
        p2=${resource/*#/}
	
	# parse resource string to look for user-defined path names 
        resources[${#resources[@]}]=$p1
        
        # use the user-defined path name exists, if it exists
	if [ -z $p2 ]; then
	    resourcePathNames[${#resourcePathNames[@]}]=$p1
        else
           resourcePathNames[${#resourcePathNames[@]}]=$p2
        fi 
        echo "...$p1"
    fi
done < RestMachine.plist

# build enums
for i in ${!resources[@]}; do
    upcase=`echo "${resources[i]}" | tr '[:lower:]' '[:upper:]'`
    upcase="$upcase"
    if [ $(($i + 1)) -lt ${#resources[@]} ]; then	
    	upcase="$upcase,"
    fi
    echo "    ${upcase}" >> $config
done

echo "} RESOURCE_TYPE;" >> $config
echo "" >> $config
echo "static NSString* RMBaseURL = @\"$BASE_URL\";" >> $config
echo ""

# define contant types
for i in ${!resources[@]}; do
    res="${resources[i]}"
    pathName="${resourcePathNames[i]}"
    capResource="$(tr '[:lower:]' '[:upper:]' <<< ${res:0:1})${res:1}"
    resourceVarNames[${#resourceVarNames[@]}]="RM$capResource"
    declaration="static NSString*"
    echo "$declaration RM$capResource = @\"$pathName\";" >> $config
done

joined="$(IFS=,; echo "${resourceVarNames[*]}")"
echo "" >> $config
echo "#define MR_RESOURCES @[$joined]" >> $config
echo "" >> $config
echo "@interface RestMachineConfig @end" >> $config

 
echo " $(tput setaf 2)RestMachine setup is complete."
echo " $(tput sgr0)$config has been updated."
