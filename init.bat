@echo off
for /f %%i in ("%0") do (
	set thePath=%%~dpi
)

doskey /macrofile=%thePath%doskey.txt
