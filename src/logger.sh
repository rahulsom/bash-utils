#!/bin/bash
#

BASH_UTIL_LOGGER=defined

debug () { echo -e "\033[00;34m$0 [$(date "+%Y-%m-%d %H:%M:%S")] DEBUG - $* \033[0m" >&2; }
info ()  { echo -e "\033[00;32m$0 [$(date "+%Y-%m-%d %H:%M:%S")] INFO  - $* \033[0m" >&2; }
warn ()  { echo -e "\033[00;33m$0 [$(date "+%Y-%m-%d %H:%M:%S")] WARN  - $* \033[0m" >&2; }
error () { echo -e "\033[00;31m$0 [$(date "+%Y-%m-%d %H:%M:%S")] ERROR - $* \033[0m" >&2; }
fatal () { echo -e "\033[01;31m$0 [$(date "+%Y-%m-%d %H:%M:%S")] FATAL - $* \033[0m" >&2; }

#
# Test case
#
if [ $(basename $0) = logger.sh ]; then
    debug HELLO
    info HELLO
    warn HELLO
    error HELLO
    fatal HELLO
fi
