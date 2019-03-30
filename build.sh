SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd $SCRIPT_DIR
mkdir build
cd build
conan install ..
cmake ..
cmake --build .
popd
