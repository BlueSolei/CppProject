@echo off
setlocal
set SH="c:\Program Files\Git\bin\sh.exe"
if exist %SH% (
    %SH% init.sh %*
) else (
    init.sh %*
)
endlocal
