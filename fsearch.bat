@echo off
setlocal

if [%*]==[] (
	echo.Finds given string in all text files in the current directory and its subdirectories
	echo.USAGE: fsearch.bat string to search
	exit /b 0
)

set SKIPPED_EXTS=.exe .pyc .dll .png Layout.xml
set SKIPPED_DIRS=\.git\
set SEARCH=%*

for /f "tokens=*" %%i in ('dir /s /b ^| find /v /i "%SKIPPED_DIRS%" ^| findstr /v /i /e "%SKIPPED_EXTS%"') do (
    for /f "tokens=*" %%j in ('findstr /i /c:"%SEARCH%" "%%i"') do (
        echo %%i:%%j
    )
)
