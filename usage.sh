#!/bin/bash

NAME="NetUsage"
DESC="A simple CLI to view your network usage since last boot."
AUTHOR="Adhiraj Sirohi"
VERSION="1.0"
GITLINK="https://github.com/Brutuski/NetUsage"
LICENSE="https://github.com/Brutuski/NetUsage/blob/master/LICENSE"

#Fetch raw network usage data
FETCH="cat /proc/net/dev"

#Colors for output
BLUE="\033[0;36m"
GREEN="\033[0;32m"
ORANGE="\033[1;31m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
NC="\033[0m"

#Factor to convert bytes to MB
factor_MB=1048576
factor_GB=1024

#Suffixes
MB="MB"
GB="GB"

while getopts i:cu:hu:pu:v flag
do
  case "${flag}" in
    i)
      interface=${OPTARG};;
    c)
      cli=true;;
    h)
      clear
      echo "Displays the total network traffic since last boot";
      echo
      echo -e "Options: \n\t ${ORANGE}-i${NC} <interface_name> Shows the Network Usage since last boot  \n\t ${ORANGE}-p${NC} <interface_name> Display in Polybar \n\t ${ORANGE}-v${NC} shows Version and Author details" ;
      echo
      echo "All output is shown in MB";
      echo
      echo -e "For more details/issues please refer to: ${BLUE}$GITLINK${NC}"
      exit;;
    p)
      polybar=true;;
    v)
      clear
      echo $NAME;
      echo $DESC;
      echo
      echo "Version:  " $VERSION;
      echo "Author:   " $AUTHOR;
      echo "Git Link: " $GITLINK;
      echo "LICENSE:   "$LICENSE;
      exit;;
    *)
      echo 
      echo -e "${RED}No Interface specified${NC}"
      echo "Please enter an interface"
      echo -e "List available interfaces with: ${YELLOW}'$'ip link${NC}"
      exit;;
  esac
done

  #Extract usage in bytes
  recieved=`$FETCH | grep $interface | awk '{print $2}'`
  transmitted=`$FETCH | grep $interface | awk '{print $10}' `

  #Calculate usage in MB
  dl_MB=$((recieved / factor_MB))
  up_MB=$((transmitted / factor_MB))

if [[ -z "$interface" ]]; then
    echo 
    echo -e "${RED}No Options specified${NC}, try -h for Help: ${YELLOW}'$'./usage.sh -h${NC}"
    exit
fi

if [[ "$cli" = true ]]; then
  echo
  echo -e "${GREEN}Download:${NC} "$dl_MB$MB
  echo -e "${BLUE}Upload:${NC} "$up_MB$MB
fi

if [[ "$polybar" = true ]]; then
    echo "DL:"$dl_MB$MB "UP:"$up_MB$MB
fi