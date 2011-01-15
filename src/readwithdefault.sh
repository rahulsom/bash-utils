#!/bin/bash
#

# readWithDefault
function readWithDefault {
    PARAMETER=$1
    VARNAME=$2    
    DEFAULT=$3
    echo -en "Enter $PARAMETER [\033[01;32m$DEFAULT\033[0m]: "
    read -e TEMPVAR
    TEMPVAR2=$(echo $TEMPVAR | head -n 1)
    if [ "$TEMPVAR2" = "" ]; then
        export $VARNAME="$DEFAULT"
    else
        export $VARNAME="$TEMPVAR2"
    fi
}

if [ $(basename $0) = readwithdefault.sh ]; then
    readWithDefault "Your name" USERNAME2 R2D2
    echo Your name is $USERNAME2
fi
