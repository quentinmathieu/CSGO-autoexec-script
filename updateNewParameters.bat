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
if not "%csgoPath%"=="" set /p yesOrNot=Is that correct[y/n]?
echo.
if not "%yesOrNot%"=="y" set /p csgoPath=Enter %ESC%[7myour new csgo path%ESC%[0m :
if not "%userID%"=="" echo %ESC%[93m%userID%%ESC%[0m
if not "%userID%"=="" set /p yesOrNot=Is that correct[y/n]?
echo.
if not "%yesOrNot%"=="y" set /p userID=Enter %ESC%[7myour new steamID3%ESC%[0m :
if not "%name%"=="" echo %ESC%[93m%name%%ESC%[0m
if not "%name%"=="" set /p yesOrNot=Is that correct[y/n]?
echo.
if not "%yesOrNot%"=="y" set /p name=Enter %ESC%[7myour new autoexec filename (with.cfg)%ESC%[0m :

if "%csgoPath%"=="" set /p csgoPath=Enter %ESC%[7myour csgo path%ESC%[0m :
if "%userID%"=="" set /p userID=Enter %ESC%[7myour steamID3%ESC%[0m :
if "%name%"=="" set /p name=Enter %ESC%[7myour autoexec filename (with.cfg)%ESC%[0m :

CALL bin\build_datas.bat

set userID="%userID:~5,-1%"
set currentDir=%~dp0
set csgoPath=^"%csgoPath%^"
cd %csgoPath%
cd ..\..\..\userdata\%userID%\config\
for /f "tokens=*" %%A in ('find "LaunchOptions" localconfig.vdf') do set launchOptions="%%A"
set launchOptions=%launchOptions:*LaunchOptions=%
for /f "tokens=*" %%A in (%launchOptions%) do set launchOptions="%%A"
set launchOptions=%launchOptions:~2,-2%
cd %currentDir%
echo set launchOptions=%launchOptions%> bin\launchOptions.bat
call bin\launchOptions.bat >nul
if not "%launchOptions%"=="" set /p yesOrNot=your actual launch options are "%ESC%[93m%launchOptions%%ESC%[0m" do you want to change it[y/n]?
if "%launchOptions%"=="" set /p yesOrNot=your actual launch options are "+exec %name%", do you want to add more[y/n]?
set file_tmp=tmp.vdf
cd %csgoPath%
cd ..\..\..\userdata\%userID%\config\

set search="LaunchOptions"		""
set replace="LaunchOptions"		"+exec %name%"
set textfile=localconfig.vdf
set newfile=%file_tmp%
(for /f "delims=" %%i in (%textfile%) do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    set "line=!line:%search%=%replace%!"
    echo(!line!
    endlocal
))>"%newfile%"
del %textfile%
rename %newfile%  %textfile%

::set search="LaunchOptions"		""
::set replace="LaunchOptions"		"+exec %name%"
::set textfile=localconfig.vdf
::set newfile=tmp.vdf
::(for /f "delims=" %%i in (%textfile%) do (
::    set "line=%%i"
::    setlocal enabledelayedexpansion
::    set "line=!line:%search%=%replace%!"
::    echo(!line!
::    endlocal
::)))>"%newfile%"
::del %textfile%
::rename %newfile%  %textfile%

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