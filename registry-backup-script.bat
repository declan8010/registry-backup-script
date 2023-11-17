@echo off

ECHO.
ECHO ############################################################
ECHO ##                                                        ## 
ECHO ##               Registry Backup Script                   ##
ECHO ##              Version 1.0.0 17/11/2023                  ##
ECHO ##                                                        ##
ECHO ##  https://github.com/declan1080/registry-backup-script  ##
ECHO ##                                                        ## 
ECHO ############################################################
ECHO.

setlocal EnableDelayedExpansion

:: Prompt the user for the backup path
set /p backup_path="Enter the path where you want the backup to be saved: "

:: Get the current date
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do set datetime=%%I
for /f "tokens=%datetime:~4,2% delims=," %%M in ("Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec") do set month=%%M
set date=%datetime:~6,2%-%month%-%datetime:~0,4%
echo.
:: Check if the file already exists
if exist "%backup_path%\Registry_Backup_%date%.reg" (
    set /p overwrite="A file with the same name already exists. Do you want to overwrite it? (y/n): "
    if /i "%overwrite%"=="n" (
        echo Backup cancelled.
        goto :eof
    )
)

echo Please wait while the backup is being taken. This may take some time...
:: Export the registry
regedit /E "%backup_path%\Registry_Backup_%date%.reg"
echo.
echo Backup saved to: "%backup_path%\Registry_Backup_%date%.reg"

endlocal
echo.
pause