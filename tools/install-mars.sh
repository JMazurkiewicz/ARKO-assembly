#!/bin/bash

red=$(tput setaf 1)
green=$(tput setaf 2)
normal=$(tput sgr0)

install_path="."

install() {
  local url="http://courses.missouristate.edu/kenvollmar/mars/MARS_4_5_Aug2014/Mars4_5.jar"
  echo "${green}Downloading MARS from \"${url}\".${normal}"
  wget $url
}

if [[ $# -gt 1 ]]; then
  printf "${red}Invalid amount of arguments (expected 0 or 1, got %d).${normal}\n" $#
else
  if [[ $# -eq 1 ]]; then
    install_path=$1
  fi

  cd $install_path &> /dev/null
  if [[ $? -eq 0 ]]; then
    install
  else
    echo "${red}Invalid path \"${install_path}\".${normal}"
  fi
fi
