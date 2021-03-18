@echo off 

setlocal
call :setESC

set /p yesOrNot=%ESC% DDo you want %ESC%[7mupdate%ESC%[0m your new parameters and autoexec[y/n]?%ESC%[0m
echo.
if not "%yesOrNot%"=="y" echo.& echo.%ESC%[7mabord... %ESC%[0m
if not "%yesOrNot%"=="y" pause
if not "%yesOrNot%"=="y" exit
CALL bin\datas.bat

if not "%csgoPath%"=="" echo %ESC%[93m%csgoPath%%ESC%[0m
if not "%csgoPath%"=="" set /p yesOrNot=Is this the correct csgo path[y/n]?
echo.
if not "%yesOrNot%"=="y" set /p csgoPath=Enter %ESC%[7myour new csgo path%ESC%[0m :
if not "%userID%"=="" echo %ESC%[93m%userID%%ESC%[0m
if not "%userID%"=="" set /p yesOrNot=Is this the correct SteamID3[y/n]?
echo.
if not "%yesOrNot%"=="y" set /p userID=Enter %ESC%[7myour new steamID3%ESC%[0m :
if not "%name%"=="" echo %ESC%[93m%name%%ESC%[0m
if not "%name%"=="" set /p yesOrNot=Is this the correct autoexec filename? (with .cfg)[y/n]?
echo.
if not "%yesOrNot%"=="y" set /p name=Enter %ESC%[7myour new autoexec filename (with.cfg)%ESC%[0m :

if "%csgoPath%"=="" set /p csgoPath=Enter %ESC%[7myour csgo path%ESC%[0m :
if "%userID%"=="" set /p userID=Enter %ESC%[7myour steamID3%ESC%[0m :
if "%name%"=="" set /p name=Enter %ESC%[7myour autoexec filename (with.cfg)%ESC%[0m :

CALL bin\build_datas.bat
CALL bin\datas.bat

set userID="%userID:~5,-1%"
set currentDir=%~dp0
set csgoPath=^"%csgoPath%^"
cd %csgoPath%
set configPath=..\..\..\userdata\%userID%\config\
cd %configPath%
for /f "tokens=*" %%A in ('find "LaunchOptions" localconfig.vdf') do set launchOptions="%%A"
set launchOptions=%launchOptions:*LaunchOptions=%
for /f "tokens=*" %%A in (%launchOptions%) do set launchOptions="%%A"
set launchOptions=%launchOptions:~2,-2%
cd %currentDir%
echo set launchOptions=%launchOptions%> bin\launchOptions.bat
call bin\launchOptions.bat >nul
if not "%launchOptions%"=="" set /p OdlYesOrNot=Your actual launch options are "%ESC%[93m%launchOptions%%ESC%[0m" do you want to change it[y/n]?
if "%launchOptions%"=="" set /p newYesOrNot=Your launch options will be "%ESC%[93m+exec %name%%ESC%[0m", do you want to add more options(to increase fps, set tickrate to 128, etc...)[y/n]?

if "%OdlYesOrNot%"=="n" goto noUpdate
if "%newYesOrNot%"=="n" set replace="LaunchOptions"		"+exec %name%" && goto update


if "%OdlYesOrNot%"=="y" CALL bin\moreOptions.bat
if "%newYesOrNot%"=="y" CALL bin\moreOptions.bat


:update
cd %csgoPath%
cd %configPath%
if "%launchOptions%"=="" set search="LaunchOptions"		""
if not "%launchOptions%"=="" set search=%launchOptions%
set textfile=localconfig.vdf
set newfile=tmp.vdf
echo %replace%
::if not "%search%"=="%replace%" goto noUpdate >nul
pause
(for /f "delims=" %%i in (%textfile%) do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    set "line=!line:%search%=%replace%!"
    echo(!line!
    endlocal
))>%newfile%
)
del %textfile% >nul
rename %newfile%  %textfile%

:noUpdate
cd %currentDir%
type bin\datas.bat bin\structure.bat > bin\run.bat

CALL bin\run.bat

pause
:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B 0
)

pause