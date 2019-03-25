pushd %~dp0
if "%1"=="clean" (rd /q/s build)
mkdir build
cd build
conan install ..
cmake .. -G "Visual Studio 15 2017"
cmake --build .
popd

