#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
pushd $SCRIPT_DIR

if ! which conan; then
    echo "Conan C++ package manager isn't installed. installing it now"
    pip install conan
    conan remote add bincrafters https://api.bintray.com/conan/bincrafters/public-conan
    conan remote add outcome https://api.bintray.com/conan/ned14/Outcome
fi
if [[ "$*" = *clean* ]]; then rm -rf build; fi
if [ ! -d "build" ]; then mkdir build; fi
cd build
if [[ "$*" = *wasm* ]]; then
    conan install .. -pr ../env/emscripten.profile
    source activate.sh
fi
cmake .. -DCMAKE_BUILD_TYPE=Debug
cmake --build .
cmake --build . --target install
if [[ "$*" = *wasm* ]]; then
    source deactivate.sh
fi

# uncomment if need installation
popd
