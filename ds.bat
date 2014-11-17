@echo off
setlocal
setlocal enabledelayedexpansion

rem Count size of subfolders

for /f "tokens=*" %%i in ('dir /b /a:d %1') do (
	set size=0
	for /r %%x in ("%%i\*") do set /a size+=%%~zx
	echo.!size! %%i
)

:theEnd
endlocal