@echo off
setlocal

:: Get the current date
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do set datetime=%%I
for /f "tokens=%datetime:~4,2% delims=," %%M in ("Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec") do set month=%%M
set date=%datetime:~6,2%-%month%-%datetime:~0,4%

:: Prompt the user for the backup path
set /p backup_path="Enter the path where you want the backup to be saved: "

:: Check if the file already exists
if exist "%backup_path%\Registry_Backup_%date%.reg" (
    set /p overwrite="A file with the same name already exists. Do you want to overwrite it? (y/n): "
    if /i "%overwrite%"=="n" (
        echo Backup cancelled.
        goto :eof
    )
)

:: Export the registry
regedit /E "%backup_path%\Registry_Backup_%date%.reg"

endlocal