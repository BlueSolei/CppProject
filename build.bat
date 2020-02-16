@echo off
setlocal
set SH="c:\Program Files\Git\bin\sh.exe"
if exist %SH% (
    %SH% build.sh %*
) else (
    build.sh %*
)
endlocal
