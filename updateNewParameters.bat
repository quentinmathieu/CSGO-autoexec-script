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
CALL bin\launchOptions.bat
set userID="%userID:~5,-1%"
set currentDir=%~dp0
set csgoPath=^"%csgoPath%^"
cd %csgoPath%
set configPath=..\..\..\userdata\%userID%\config\
cd %configPath%

::searshing "Software"
for /f "delims=:" %%a in ('findstr /n ""Software"" localconfig.vdf') do set line=%%a&
::findstr /n . localconfig.vdf | findstr ^%line%:
::searshing "730"
for /f "delims=:" %%a in ('findstr /n ""730"" localconfig.vdf') do ( if %%a GTR %line% set csLine=%%a& goto lineFound)
:lineFound
::findstr /n . localconfig.vdf | findstr ^%csLine%:
set /a csLineOne=%csLine%+1

for /f "tokens=1,* delims=:" %%i in ('findstr /n /r . localconfig.vdf') do if %%i geq %csLineOne% if %%i leq %csLineOne% echo %%j>newtxt.txt
::searshing "{" the line AFTER 730 (csLineOne)
::findstr /n /r /C:"{" newtxt.txt

If %ERRORLEVEL% EQU 1 echo %ESC%[101mERROR, file corrupted%ESC%[0m& goto noUpdate
::else "{" found so change the launchOptions value
for /f "delims=:" %%a in ('findstr /n /i "LaunchOptions" localconfig.vdf') do ( if %%a GTR %csLine% set launchLine=%%a& goto launchFound)
::findstr /n . localconfig.vdf | findstr ^%launchLine%:
:launchFound
::findstr /n . localconfig.vdf | findstr ^%launchLine%:
::for /f "tokens=1,* delims=:" %%i in ('findstr /n /i "LaunchOptions" localconfig.vdf') do ( if %%i GTR %csLine% set launchOptions=%%j& goto launchOptionsOk)
::launchOptionsOk

for /f "tokens=*" %%A in ('find "LaunchOptions" localconfig.vdf') do set launchOptions="%%A"
set launchOptions=%launchOptions:*LaunchOptions=%

for /f "tokens=*" %%A in (%launchOptions%) do set launchOptions="%%A"
set launchOptions=%launchOptions:~2,-2%
cd %currentDir%
echo %launchOptions%
echo %launchOptionsSave%
pause
if "%launchOptionsSave%"=="%launchOptions%" goto launchOptionsMatch

if "%launchOptionsSave%"=="" goto launchOptionsMatch

:chooseOptions
echo.
echo We found 2 different versions of your launch options :
echo 1.%ESC%[93m%launchOptions%%ESC%[0m currently setup in csgo property
echo 2.%ESC%[93m%launchOptionsSave%%ESC%[0m from the last use of this script
echo 3.%ESC%[93mCreate a new one%ESC%[0m
echo.
set /p chooseOptions=Wich one do you want to use[1/2/3]?
if "%chooseOptions%"=="1" if not "%launchOptions%"=="" set oldYesOrNot=n& goto moreOptions
if "%chooseOptions%"=="1" if "%launchOptions%"=="" set newYesOrNot=n& goto moreOptions
if "%chooseOptions%"=="2" if not "%launchOptions%"=="" set oldYesOrNot=n& set replace=%launchOptionsSave%& goto afterMoreOptions
if "%chooseOptions%"=="2" if "%launchOptions%"=="" set newYesOrNot=n& set replace=%launchOptionsSave%& goto afterMoreOptions
if "%chooseOptions%"=="3" if not "%launchOptions%"=="" set oldYesOrNot=y& goto moreOptions
if "%chooseOptions%"=="3" if "%launchOptions%"=="" set newYesOrNot=y& goto moreOptions
if not "%chooseOptions%"=="1" if not "%chooseOptions%"=="2" if not "%chooseOptions%"=="3" echo.& echo.%ESC%[41mBad input, retry%ESC%[0m & goto :chooseOptions
:launchOptionsMatch
echo %launchOptions%
pause
if not "%launchOptions%"=="" set /p oldYesOrNot=Your actual launch options are "%ESC%[93m%launchOptions%%ESC%[0m" do you want to change it[y/n]?
if "%launchOptions%"=="" set /p newYesOrNot=Your launch options will be "%ESC%[93m+exec %name%%ESC%[0m", do you want to add more options(to increase fps, set tickrate to 128, etc...)[y/n]?

:moreOptions
if "%oldYesOrNot%"=="y" CALL bin\moreOptions.bat
if "%oldYesOrNot%"=="n" echo.& echo.%ESC%[43mLaunch options haven't been update%ESC%[0m& set replace=%launchOptions%


if "%newYesOrNot%"=="y" CALL bin\moreOptions.bat
if "%newYesOrNot%"=="n" set replace=+exec %name%

:afterMoreOptions
if "%launchOptions%"=="" echo set launchOptionsSave=%replace%> bin\launchOptions.bat
if "%launchOptions%"=="" set search="LaunchOptions"		""& set replace="LaunchOptions"		"%replace%"
if "%launchOptions%"=="%replace%" goto noUpdate
cd %csgoPath%
cd %configPath%



if not "%launchOptions%"=="" set search=%launchOptions%
set textfile=localconfig.vdf
set newfile=tmp.vdf

for /f "tokens=1,* delims=:" %%i in ('findstr /n /r . localconfig.vdf') do if %%i geq %launchLine% if %%i leq %launchLine% echo %%j
(for /f "tokens=1,* delims=:" %%i in ('findstr /n /r .  %textfile%') do (
    set "line=%%j"
    setlocal enabledelayedexpansion
    ::changer la valeur que si  c'est la bonne ligne
    if %%i geq %launchLine% if %%i leq %launchLine% set "line=!line:%search%=%replace%!"
    echo(!line!
    endlocal
))>%newfile%
)
del %textfile% >nul
rename %newfile%  %textfile%

:noUpdate
cd %currentDir%
pause
type bin\datas.bat bin\structure.bat > bin\run.bat

CALL bin\run.bat

pause
:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B 0
)

pause