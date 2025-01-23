@echo off
cls

:: Check for updates
wuauclt /detectnow
echo Checking for updates...

:: Download and install updates
wuauclt /updatenow
echo Downloading and installing updates...

:: Report update status
wuauclt /reportnow
echo Update status reported...

:: Restart the system if required
shutdown /r /t 0
echo System will restart now...
