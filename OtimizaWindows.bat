@echo on
setlocal EnableExtensions

:: ===============================
:: CHECK ADMINISTRATOR
:: ===============================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Run this script as Administrator.
    pause
    exit /b
)

title Windows Optimization - Complete (Screen Off)

:: ===============================
:: TURN OFF SCREEN
:: ===============================
echo Turning off the screen...
powershell -command "(Add-Type '[DllImport(\"user32.dll\")]^
public static extern int SendMessage(int hWnd, int hMsg, int wParam, int lParam);' -Name a -PassThru)::SendMessage(-1,0x0112,0xF170,2)" >nul 2>&1
echo Screen turned off. Script running...
echo.

echo =========================================
echo STARTING WINDOWS OPTIMIZATION
echo =========================================
echo.

:: ===============================
:: NUM LOCK
:: ===============================
echo Enabling Num Lock...
reg add "HKU\.DEFAULT\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_SZ /d 2 /f >nul 2>&1
echo.

:: ===============================
:: USER TEMP
:: ===============================
echo Cleaning user temporary files...
del /s /q "%TEMP%\*" >nul 2>&1
echo.

:: ===============================
:: SYSTEM TEMP
:: ===============================
echo Cleaning system temporary files...
del /s /q "C:\Windows\Temp\*" >nul 2>&1
echo.

:: ===============================
:: STOP UPDATE SERVICES
:: ===============================
echo Stopping Windows Update services...
net stop wuauserv /y >nul 2>&1
net stop bits /y >nul 2>&1
net stop cryptsvc /y >nul 2>&1
echo.

:: ===============================
:: CLEAN UPDATE CACHE
:: ===============================
echo Cleaning Windows Update cache...
rd /s /q "C:\Windows\SoftwareDistribution" >nul 2>&1
rd /s /q "C:\Windows\System32\catroot2" >nul 2>&1
echo.

:: ===============================
:: RECREATE FOLDERS
:: ===============================
echo Recreating folders...
md "C:\Windows\SoftwareDistribution" >nul 2>&1
md "C:\Windows\System32\catroot2" >nul 2>&1
echo.

:: ===============================
:: RESTART SERVICES
:: ===============================
echo Restarting services...
net start cryptsvc >nul 2>&1
net start bits >nul 2>&1
net start wuauserv >nul 2>&1
echo.

:: ===============================
:: FORCE WINDOWS UPDATE
:: ===============================
echo Forcing Windows Update...
usoclient StartScan
timeout /t 5 >nul
usoclient StartDownload
timeout /t 5 >nul
usoclient StartInstall
timeout /t 5 >nul
echo.

:: ===============================
:: DISK CLEANUP
:: ===============================
echo Running disk cleanup...
cleanmgr /sagerun:1 >nul 2>&1
echo.

:: ===============================
:: WINGET - FORCE UPDATE ALL
:: ===============================
echo Updating applications...
winget source update >nul 2>&1
winget upgrade --all --include-unknown --silent --accept-package-agreements --accept-source-agreements --disable-interactivity >nul 2>&1
echo.

:: ===============================
:: WINDOWS IMAGE REPAIR (DISM)
:: ===============================
echo Repairing Windows image (DISM)...
DISM /Online /Cleanup-Image /RestoreHealth >nul 2>&1
echo.

:: ===============================
:: SYSTEM FILE CHECK (SFC)
:: ===============================
echo Checking system files (SFC)...
sfc /scannow >nul 2>&1
echo.

echo =========================================
echo OPTIMIZATION COMPLETED
echo =========================================

timeout /t 5 >nul
endlocal

:: ===============================
:: SHUTDOWN COMPUTER
:: ===============================
echo Shutting down the computer in 10 seconds...
shutdown /s /t 10 /c "Windows updated, repaired and optimized."

exit /b 0