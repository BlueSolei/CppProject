#!/usr/bin/env bash

# BASH error handling:
#   exit on command failure
set -e
#   keep track of the last executed command
trap 'LAST_COMMAND=$CURRENT_COMMAND; CURRENT_COMMAND=$BASH_COMMAND' DEBUG
#   on error: print the failed command
trap 'ERROR_CODE=$?; FAILED_COMMAND=$LAST_COMMAND; tput setaf 1; echo "ERROR: command \"$FAILED_COMMAND\" failed with exit code $ERROR_CODE"; tput sgr0;' ERR INT TERM

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
pushd "$SCRIPT_DIR" >/dev/null 2>&1

if ! which conan; then
  echo "Conan C++ package manager isn't installed. installing it now"
  pip install conan
fi
if [[ "$*" = *wasm* ]]; then HOST_PLATFORM=EMSCRIPTEN; fi
if [[ "$*" = *clean* ]]; then rm -rf build; fi
if [ ! -d "build" ]; then mkdir build; fi

cd build

if [[ $HOST_PLATFORM = EMSCRIPTEN ]]; then
  CONAN_PROFILE=$SCRIPT_DIR/env/emscripten.profile
  conan install .. -pr "$CONAN_PROFILE"
  source activate.sh
fi

cmake .. -DCMAKE_BUILD_TYPE=Debug -DCONAN_PROFILE=$CONAN_PROFILE
cmake --build .
cmake --install . --prefix ..

if [[ $HOST_PLATFORM = EMSCRIPTEN ]]; then
  source deactivate.sh
fi

popd >/dev/null 2>&1
