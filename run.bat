pushd %~dp0
cd build\bin
if "%1"=="test" (DummyTest.exe) else (Dummy.exe)
popd
