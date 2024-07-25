@echo off
setlocal

:: Attempt to activate the LivePortrait environment and capture any error messages in a file
echo Activating the LivePortrait environment...
call LivePortrait_env\Scripts\activate > nul 2>env_error.txt

:: Check the exit status of the previous command to see if the activation was successful
if %ERRORLEVEL% NEQ 0 (
    echo Activation failed. Displaying the error message:
    type env_error.txt
    echo Press any key to exit...
    pause >nul
    goto :eof
) else (
    echo Environment activated successfully.
)

:: Delete the error message file regardless of whether activation was successful
if exist env_error.txt del env_error.txt

:: Define the server's listening port
set SERVER_PORT=8890

:: Start the server in the background
echo Starting the server...
start /B python app.py

:: Wait for a moment to allow the server to start
echo Waiting for the server to start...
timeout /t 10 >nul

:: Infinite loop to keep checking the port status
:check_port
echo Checking if the server is listening on port %SERVER_PORT%...
for /f %%i in ('python check_port.py %SERVER_PORT%') do (
    if "%%i" == "LISTENING" (
        echo Server is up and running on http://127.0.0.1:%SERVER_PORT%
        :: Open the default browser to the server's URL
        start http://127.0.0.1:%SERVER_PORT%
        :: Keep the batch file running and display server output
        echo Server is running. Press Ctrl+C to stop.
        goto loop
    ) else (
        echo Server not ready, waiting 2 seconds...
        timeout /t 2 >nul
        goto check_port
    )
)

:loop
timeout /t 1 >nul
goto loop