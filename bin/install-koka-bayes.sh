#!/bin/bash
set -e

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

printf "\n"
printf "This make script ${red}MUST${reset} be run from the root directory of the koka-bayes install location!\n"

read -p "Is this run from the root of ${green}koka-bayes${reset} (y/n)? " choice
case "$choice" in
  y|Y ) echo "${green}Proceeding${reset}";;
  n|N ) exit 0;;
  * ) echo "Invalid - re run install to try again"; exit 0;;
esac

GIT_DIR=$(pwd)

LOCALS=$(pwd)/bin/local-vars.sh 
if [ ! -f "$LOCALS" ]; then
    touch $LOCALS
fi

chmod +x ./bin/local-vars.sh
source ./bin/local-vars.sh 

if [ ! -n "$KOKA_INSTALL" ]; then
  printf "\n\n"
  printf "First parameter supplied!"
  printf "Please enter the ${green}install directory of koka!${reset}\n"
  printf "This should have the form:\n"
  printf "/dir1/dir2/../koka\n"
  read install_directory
  echo "export KOKA_INSTALL=\"$install_directory\""$'\n' >>$LOCALS
  printf "Koka install directory added to ./bin/local-vars.sh!"
fi

source ./bin/local-vars.sh 

if [ ! -d "$KOKA_INSTALL/out/koka-bayes-output/" ]; then
  mkdir $KOKA_INSTALL/out/koka-bayes-output
fi

printf "${green}Successfully installed koka-bayes!${reset}"
