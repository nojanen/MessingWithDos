@echo off
setlocal

set numberOfLines=10
set filename=

for /f "tokens=1* delims=-" %%i in ("%1") do (
    if "%1"=="-%%i" (
        set numberOfLines=%%i
        set filename=%2
    ) else (
        set filename=%1
    )
)

if "%filename%"=="" goto readFromStdin
goto readFromFile

:readFromStdin
for /f "tokens=1* delims=:" %%i in ('findstr /N "^"') do (
    if %%i LEQ %numberOfLines% echo.%%j
)
goto theEnd

:readFromFile
for /f "tokens=1* delims=:" %%i in ('type "%filename%" ^| findstr /N "^"') do (
    if %%i LEQ %numberOfLines% echo.%%j
)
goto theEnd

:theEnd
endlocal
