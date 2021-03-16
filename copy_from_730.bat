@echo off 

CALL bin\datas.bat
if not "%csgoPath%"=="" echo "%csgoPath%"
if not "%csgoPath%"=="" set /p yesOrNot=Is that correct[y/n]?
if "%yesOrNot%"=="n" set /p csgoPath=Enter your csgo path :
if not "%userID%"=="" echo "%userID%"
if not "%userID%"=="" set /p yesOrNot=Is that correct[y/n]?
if "%yesOrNot%"=="n" set /p userID=Enter your userID3 :

if "%csgoPath%"=="" set /p csgoPath=Enter your csgo path :
if "%userID%"=="" set /p userID=Enter your userID3 :

echo @echo off> bin\datas.bat
echo set csgoPath=%csgoPath%>> bin\datas.bat
echo set userID=%userID%>> bin\datas.bat

set /p yesOrNot="Do you want to take your config & your video settings from current csgo settings?[y/n]"

if "%yesOrNot%"=="y" set csgoPath=^"%csgoPath%^"
if "%yesOrNot%"=="y" set currentDir=%~dp0
if "%yesOrNot%"=="y" cd %csgoPath%
echo %currentDir%
pause
if "%yesOrNot%"=="y" xcopy /y ..\..\..\userdata\%userID%\730\local\cfg\video.txt %currentDir%\video.txt*
if "%yesOrNot%"=="y" xcopy /y ..\..\..\userdata\%userID%\730\local\cfg\config.cfg %currentDir%\config.cfg*


if "%yesOrNot%"=="n" echo "Abord..."

pause

