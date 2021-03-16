@echo off 

CALL bin\datas.bat
if not "%csgoPath%"=="" echo "%csgoPath%"
if not "%csgoPath%"=="" set /p yesOrNot=Is that correct[y/n]?
if "%yesOrNot%"=="n" set /p csgoPath=Enter your csgo path :
if not "%userID%"=="" echo "%userID%"
if not "%userID%"=="" set /p yesOrNot=Is that correct[y/n]?
if "%yesOrNot%"=="n" set /p userID=Enter your userID3 :
if not "%name%"=="" echo "%name%"
if not "%name%"=="" set /p yesOrNot=Is that correct[y/n]?
if "%yesOrNot%"=="n" set /p name=Enter your autoexec file name :

if "%csgoPath%"=="" set /p csgoPath=Enter your csgo path :
if "%userID%"=="" set /p userID=Enter your userID3 :
if "%name%"=="" set /p name=Enter your autoexec file name :

echo @echo off> bin\datas.bat
echo set csgoPath=%csgoPath%>> bin\datas.bat
echo set userID=%userID%>> bin\datas.bat
echo set name=%name%>> bin\datas.bat

type bin\datas.bat bin\structure.bat > bin\run.bat

CALL bin\run.bat

pause