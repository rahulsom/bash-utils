taskdef() {
  echo -n "  * $1"
  TASKLEN=$(echo "  * $1" | wc -c)
  if [ "$#" -gt 2 ]; then
    if [ "$2" = "BRK" ]; then
      echo ""
      TASKLEN=1
      return
    fi
  fi
  if [ $TASKLEN -gt 70 ]; then
    echo ""
    TASKLEN=1
    return
  fi
  if [ "$DO_DEBUG" = "0" ]; then
    echo -ne ""
  else 
    echo ""
    TASKLEN=1
    return
  fi
}
taskok() {
  local PADDING=$((70 - TASKLEN))
  printf "%${PADDING}s [${ANESC}${ANBG}${ANG};${ANBOL}${ANEND}   OK   ${ANRESET}]\n" ""
}
taskerror() {
  local PADDING=$((70 - TASKLEN))
  printf "%${PADDING}s [${ANESC}${ANBG}${ANR};${ANBOL}${ANEND}  FAIL  ${ANRESET}]\n" "" 
}
