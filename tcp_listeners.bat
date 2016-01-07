@echo off
setlocal enabledelayedexpansion
goto main

:cut_string
rem Parameters:
rem   %1 : Name of return variable
rem   %2 : The string
rem   %3 : Which field is output
rem   %4 : Delimiter
for /f "tokens=%3 delims=%4" %%i in (%2) do (
	set %1=%%i
)
exit /b 0


:main
for /f "tokens=2,5 delims= " %%i in ('netstat -ano -p TCP ^| find /i "listening"') do (
	set address=%%i
	set pid=%%j

	for /f "tokens=1" %%k in ('tasklist /nh /fi "pid eq !pid!"') do (
		set imagename=%%k
		call :cut_string port "!address!" 2 :
		echo.Process '!imagename!' ^(pid: !pid!^) listens port !port!
	)
)

:the_end
