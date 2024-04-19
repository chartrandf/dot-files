#!/bin/bash
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

echo "
${WHITE}✨ Almost there, remaining manual steps ✨${RESTORE}

- ${WHITE}Configure Rectangle:${RESTORE} Open > Settings > Import > ${LBLUE}/manual-steps/files/RectangleConfig.json${RESTORE}
- ${WHITE}OSX Manual Configuration:${RESTORE}
  - Increase key speed and reduce delay
  - Touchpad settings here: ${LBLUE}/manual-steps/files/trackpad${RESTORE}
- ${WHITE}Apple Calendar${RESTORE}:
  - Configure work calendar
  - Configure Reminders > Work Account > Events > At the time of the event
- ${WHITE}Itsycal${RESTORE}:
  - Itsycal settings here: ${LBLUE}/manual-steps/files/itsycal${RESTORE}
  - Control Center settings (hide default time): ${LBLUE}/manual/steps/file/control-center${RESTORE}
"
