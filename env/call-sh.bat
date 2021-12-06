@echo off
setlocal
set SH="c:\Program Files\Git\bin\bash.exe"
if not exist %SH% (set SH="c:\Program Files\Git\bin\sh.exe")
if exist %SH% (
    %SH% %*
) else (
    %*
)
endlocal
