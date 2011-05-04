#!/bin/bash
#

ANESC="\033["
ANREG="00"
ANBOL="01"
ANDIS="02"
ANUND="04"
ANSTR="09"

ANBG="4"
ANFG="3"

ANK="0"
ANR="1"
ANG="2"
ANY="3"
ANB="4"
ANM="5"
ANC="6"
ANW="7"
ANDEF="8"

ANEND="m"

# Reset
ANRESET="${ANESC}${ANREG};${ANBG}${ANDEF};${ANFG}${ANDEF}${ANEND}"

#
# Test case
#
if [ $(basename $0) = colors.sh ]; then
  echo -e "${ANESC}${ANSTR};${ANBOL};${ANBG}${ANG}${ANEND}Something${ANRESET}"
fi
