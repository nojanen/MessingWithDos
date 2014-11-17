@echo off

rem Add current branch to prompt (override cd -command with doskey by init.bat)
rem Change the path of your git.exe (without whitespaces) to the for -command.

if [%*]==[] (
    cd
) else if [%1]==[/D] (
    cd %*
) else if [%1]==[/d] (
    cd %*
) else (
    cd /D %*
)

set PROMPT=$P$G
for /f "tokens=2" %%i in ('C:\PROGRA~2\Git\cmd\git.exe branch 2^>NUL ^| findstr /c:"*"') do (
    set PROMPT=$P [%%i]$G
)
