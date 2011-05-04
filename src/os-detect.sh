#!/bin/bash
#

OSName=UNKNOWN
OSRelease=UNKNOWN
if [ -f /etc/redhat-release ]; then
  if [ $(cat /etc/redhat-release | cut -d " " -f 1) = CentOS ]; then
    OSName=CentOS
    OSRelease=$(cat /etc/redhat-release | xargs -n 1 | head -n $((`cat /etc/redhat-release | xargs -n 1 | wc -l` - 1)) | tail -n 1)
  fi
  if [ $(cat /etc/redhat-release | cut -d " " -f 1) = Red ]; then
    if [ $(cat /etc/redhat-release | cut -d " " -f 2) = Hat ]; then
      OSName=RedHat
      OSRelease=$(cat /etc/redhat-release | xargs -n 1 | head -n $((`cat /etc/redhat-release | xargs -n 1 | wc -l` - 1)) | tail -n 1)
    fi
  fi
fi
if [ -f /etc/lsb-release ]; then
  if [ $(cat /etc/lsb-release | grep DISTRIB_ID| cut -d= -f2) = Ubuntu ]; then
    OSName=Ubuntu
    OSRelease=$(cat /etc/lsb-release | grep DISTRIB_RELEASE| cut -d= -f2)
  fi
fi

if [ $(basename $0) = os-detect.sh ]; then
  echo $OSName
  echo $OSRelease
fi

