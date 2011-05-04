LINELEN=68
ML=0
taskdef() {
  if [ $ML = 1 ]; then
    echo -e "${ANESC}${ANDIS}${ANEND} -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  ${ANRESET}"
    echo "  * $1"
    TASKLEN=1
  else
    echo -n "  * $1"
    TASKLEN=$(echo "  * $1" | wc -c)
  fi
  if [ "$#" -gt 2 ]; then
    if [ "$2" = "BRK" ]; then
      echo ""
      TASKLEN=1
      return
    fi
  fi
  if [ $TASKLEN -gt $LINELEN ]; then
    echo ""
    TASKLEN=1
    return
  fi
  if [ "$SX_DEBUG" = "0" ]; then
    echo -ne ""
  else 
    echo ""
    TASKLEN=1
    return
  fi
}
taskok() {
  local PADDING=$((LINELEN - TASKLEN))
  printf "%${PADDING}s [${ANESC}${ANBG}${ANG};${ANBOL}${ANEND}   OK   ${ANRESET}]\n" ""
}
taskerror() {
  local PADDING=$((LINELEN - TASKLEN))
  printf "%${PADDING}s [${ANESC}${ANBG}${ANR};${ANBOL}${ANEND}  FAIL  ${ANRESET}]\n" "" 
}
