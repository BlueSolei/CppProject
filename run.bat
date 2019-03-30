pushd %~dp0
cd build\bin
if "%1"=="tests" (DummyTest.exe) else (Dummy.exe)
popd
