@echo off

if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

@cd /d "%~dp0"
echo.>"C:\DisplayFix\DONOTDELETE.txt"
@goto %PROCESSOR_ARCHITECTURE%
@exit

:AMD64
@cmd /c deviceinstaller64.exe install usbmmidd.inf usbmmidd
@cmd /c deviceinstaller64.exe enableidd 1
@schtasks /Create /SC ONSTART /TN Scheduled /TR %cd%\DisplayOnStart.bat /RL HIGHEST /RU SYSTEM
@goto end

:x86
@cmd /c deviceinstaller.exe install usbmmidd.inf usbmmidd
@cmd /c deviceinstaller.exe enableidd 1
@schtasks /Create /SC ONSTART /TN Scheduled /TR %cd%\DisplayOnStart.bat /RL HIGHEST /RU SYSTEM

:end
@shutdown /r /f /t 0
