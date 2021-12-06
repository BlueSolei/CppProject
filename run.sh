#!/usr/bin/env bash

# BASH error handling:
#   exit on command failure
set -e
#   keep track of the last executed command
trap 'LAST_COMMAND=$CURRENT_COMMAND; CURRENT_COMMAND=$BASH_COMMAND' DEBUG
#   on error: print the failed command
trap 'ERROR_CODE=$?; FAILED_COMMAND=$LAST_COMMAND; tput setaf 1; echo "ERROR: command \"$FAILED_COMMAND\" failed with exit code $ERROR_CODE"; tput sgr0;' ERR INT TERM

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
pushd $SCRIPT_DIR
cd bin
if [[ "$1" != "tests" ]]; then
    if [[ -f dummy.html ]]; then
        source ../activate.sh
        emrun ./dummy.html
        source ../deactivate.sh
    else
        ./dummy
    fi
else
    ./dummy-test
fi
popd
