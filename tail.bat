@echo off
setlocal enabledelayedexpansion

rem ============================================================================
rem Shows last lines of the file or stdout
rem 
rem Script creates a ring-buffer that is updated until the end of file. And
rem after that, the buffer is printed out.
rem
rem USAGE: tail.bat [-n] [filename]
rem
rem Arguments:
rem     -n          (n=number) Number of lines to be shown. Default is -10
rem     filename    Filename
rem
rem Examples:
rem     Show last 10 lines of the file:
rem         tail file.txt
rem     Show last 5 rows of dir:
rem      dir | tail -5
rem ============================================================================

set numberOfLines=10
set filename=
set index=0

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
for /f "tokens=*" %%i in ('findstr /N "^"') do (
    set /a index=!index! + 1
    set /a index=!index! %% %numberOfLines%
    set buffer[!index!]=%%i
)
goto showResults

:readFromFile
for /f "tokens=*" %%i in ('type %filename% ^| findstr /N "^"') do (
    set /a index=!index! + 1
    set /a index=!index! %% %numberOfLines%
    set buffer[!index!]=%%i
)
goto showResults

:showResults
for /l %%i in (1,1,%numberOfLines%) do (
    set /a index=!index! + 1
    set /a index=!index! %% %numberOfLines%
    
    rem Print only lines if they are set (in case of file is shorter than buffer)
    if defined buffer[!index!] (
        rem Only way to access the parameter as !buffer[!index!]! does not work
        for %%j in (!index!) do (
            rem Take out the line numbers. If those does not exist, leading spaces would be lost
            for /f "tokens=1* delims=:" %%k in ("!buffer[%%j]!") do (
                echo.%%l
            )
        )
    )
)
goto theEnd

:theEnd
endlocal
