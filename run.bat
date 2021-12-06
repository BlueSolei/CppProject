@echo off

if "%1"=="/?" (
    echo Usage: run [tests]
    exit /b
)

pushd %~dp0
cd bin
if "%1"=="tests" (dummy-test.exe) else (dummy.exe)
popd
