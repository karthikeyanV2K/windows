@echo off
%temp% and del /q /f /s
del /q /f /s %systemroot%\temp\*
del /q /f /s "%programdata%\Microsoft\Windows Defender\Scans\*"
rd /s /q C:\$Recycle.Bin
