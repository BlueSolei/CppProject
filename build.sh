pushd .
mkdir build
cd build
conan install ..
cmake ..
cmake --build .
popd
