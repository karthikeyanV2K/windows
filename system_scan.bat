@echo off
cls

:: System Files and Registry
echo Scanning system files and registry...
sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth
regsvr32 /s *.dll

:: Disk and File System
echo Scanning disk and file system...
chkdsk /f /r
chkdsk /f /r /x
defrag /c /u /v

:: Memory and Performance
echo Scanning memory and performance...
tasklist /v
taskkill /im <process_name> (optional)
perfmon

:: Network and Internet
echo Scanning network and internet...
ipconfig /release
ipconfig /renew
netsh int ip reset
netsh winsock reset

:: System Configuration
echo Scanning system configuration...
msconfig
systeminfo
driverquery

:: Security
echo Scanning security...
windows defender
netsh advfirewall set allprofiles state on

:: Other
echo Scanning other system components...
eventvwr
dxdiag
msinfo32

echo Scan complete!


