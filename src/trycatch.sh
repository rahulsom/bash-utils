#!/bin/bash
#

if [ "$BASH_UTIL_LOGGER" != "defined" ]; then
    source $(dirname $0)/logger.sh
fi

#
# try-catch-finally for bash
# Usage: 
#    trycatch \
#       TRY-STATEMENTS-COUNT (TRY-STATEMENTS) \
#       CATCH-STATEMENTS-COUNT (CATCH-STATEMENTS) \
#       [ FINALLY-STATEMENTS-COUNT (FINALLY-STATEMENTS)]
# Example:
#    trycatch \
#       2 \
#           "cat /etc/init.d/postgresql-8.4" \
#           "cat /xx" \
#       1 \
#           "echo Sorry" \
#       1 \
#           "echo Done"
#

trycatch () {
    if [ $# ]; then
        TRYSTMTS=$1
        shift
        DOTRY=1

        info "In Try block: $TRYSTMTS to execute"
        for i in $(seq 1 1 $TRYSTMTS) 
        do
            TRY=$1
            shift
            debug "$TRY"
            if [ $DOTRY ]; then
                $TRY
                if [ $? != 0 ]; then
                    error FAILURE OCCURED
                    DOTRY=0
                fi
            fi
        done
        CATCHSTMTS=$1
        shift
        if [ $DOTRY = 0 ]; then
            info "In catch block"
        fi
        for i in $(seq 1 1 $CATCHSTMTS) 
        do
            CATCH=$1
            shift
            if [ $DOTRY = 0 ]; then
                debug $CATCH
                $CATCH
            fi
        done
        if [ $# ]; then
            FINALLYSTMTS=$1
            shift
            info "In finally block"
            for i in $(seq 1 1 $FINALLYSTMTS) 
            do
                FINALLY=$1
                shift
                debug $FINALLY
                $FINALLY
            done
        fi
    else
        warn Nothing to run
    fi
}

#
# Test case
#
if [ $(basename $0) = trycatch.sh ]; then
    trycatch \
        2 \
            "cat /etc/init.d/postgresql-8.4" \
            "cat /xx" \
        1 \
            "echo Sorry" \
        1 \
            "echo Done"
fi
