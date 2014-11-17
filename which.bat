@echo off
setlocal enabledelayedexpansion

if [%*]==[] (
	echo.Find given file from path.
	echo.USAGE which.bat filename
	exit /b 0
)

call :findFileFromPath %1
call :findFileFromPath %1.bat
call :findFileFromPath %1.com
call :findFileFromPath %1.exe
call :findFileFromPath %1.cmd
goto theEnd

:findFileFromPath
for /f %%i in ("%1") do (
	set match=%%~$path:i
	if not "!match!"=="" echo.!match!
)
exit /b

:theEnd
endlocal
