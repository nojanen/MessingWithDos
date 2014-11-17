@echo off
C:\PROGRA~2\Git\cmd\git.exe %*
set PROMPT=$P$G
for /f "tokens=2" %%i in ('C:\PROGRA~2\Git\cmd\git.exe branch 2^>NUL ^| findstr /c:"*"') do (
    set PROMPT=$P [%%i]$G
)
