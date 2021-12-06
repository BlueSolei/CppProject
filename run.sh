#!/usr/bin/env bash

# BASH error handling:
#   exit on command failure
set -e
#   keep track of the last executed command
trap 'LAST_COMMAND=$CURRENT_COMMAND; CURRENT_COMMAND=$BASH_COMMAND' DEBUG
#   on error: print the failed command
trap 'ERROR_CODE=$?; FAILED_COMMAND=$LAST_COMMAND; tput setaf 1; echo "ERROR: command \"$FAILED_COMMAND\" failed with exit code $ERROR_CODE"; tput sgr0;' ERR INT TERM

function usage() {
  echo "usage: ./run.sh [OPTIONS]"
  echo "  run dummy"
  echo
  echo "OPTIONS: "
  echo "  -h | --help: show this help"
  echo "  -t | --tests: run dummy-test insead of dummy"
}

# CLI
RUN_EXE=1
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
  -h | --help)
    shift
    usage
    exit 0
    ;;
  -t | --tests)
    unset RUN_EXE
    shift
    continue
    ;;
  *)
    echo "Error: Unknown parameter \"${key}\""
    usage
    exit 2
    ;;
  esac
done

# run exe\tests
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
pushd "$SCRIPT_DIR/bin" >/dev/null 2>&1
if [[ $RUN_EXE ]]; then
  if [[ -f dummy.html ]]; then
    source ../build/activate.sh
    emrun ./dummy.html
    source ../build/deactivate.sh
  else
    ./dummy
  fi
else
  if [[ -f dummy-test.html ]]; then
    source ../build/activate.sh
    emrun ./dummy-test.html
    source ../build/deactivate.sh
  else
    ./dummy-test
  fi
fi
popd >/dev/null 2>&1
