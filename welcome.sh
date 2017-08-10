#!/bin/bash
declare -a LOADING=("⣾" "⣽" "⣻" "⢿" "⡿" "⣟" "⣯" "⣷")

WELCOME_MESSAGE="Welcome in your terminal Francis 💻"
WRITING_STRING=""


RESTORE='\033[0m'

RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'

LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'

function clearLastLine() {
  tput cuu 1 && tput el;
}

function writingAnimation() {
  WRITING_STRING=$1

  for(( i=0; i<=${#WELCOME_MESSAGE}; i++)); do
    for iii in "${LOADING[@]}"; do
      WRITING_STRING="${WELCOME_MESSAGE:0:$i}${iii}"
      generateWritingString
    done
    WRITING_STRING=${WELCOME_MESSAGE:0:$i}
    generateWritingString
  done

  echo "${LGREEN}${WRITING_STRING}${RESTORE}"
}

function generateWritingString() {
  echo "${LGREEN}${WRITING_STRING}${RESTORE}"
  clearLastLine
}

writingAnimation