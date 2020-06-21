@echo off

if "%1" == "/?" (
    echo Usage: init.bat
    echo    Initalize the project. 
    echo    Call this first thing, as its recreate the git repo.
    exit \b 0
)

setlocal
set SH="c:\Program Files\Git\bin\sh.exe"
if exist %SH% (
    %SH% init.sh %*
) else (
    init.sh %*
)
endlocal
