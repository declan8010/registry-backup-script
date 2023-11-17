@echo off
setlocal

:: Get the current date
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do set datetime=%%I
for /f "tokens=%datetime:~4,2% delims=," %%M in ("Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec") do set month=%%M
set date=%datetime:~6,2%-%month%-%datetime:~0,4%

:: Prompt the user for the backup path
set /p backup_path="Enter the path where you want the backup to be saved: "

:: Export the registry
regedit /E "%backup_path%\registry_backup_%date%.reg"

endlocal