@echo off 

setlocal
call :setESC

set /p yesOrNot=Do you want to  %ESC%[7mcopy current parameters%ESC%[0m from the game[y/n]?
echo.
if not "%yesOrNot%"=="y" echo %ESC%[101mnothing has been copied... %ESC%[0m
if not "%yesOrNot%"=="y" pause
if not "%yesOrNot%"=="y" exit
CALL bin\datas.bat
if not "%csgoPath%"=="" echo %ESC%[93m%csgoPath%%ESC%[0m
if not "%csgoPath%"=="" set /p yesOrNot=Is this the correct csgo path[y/n]?
if not "%csgoPath%"=="" echo.
if not "%yesOrNot%"=="y" set /p csgoPath=Enter %ESC%[7myour new csgo path%ESC%[0m :
if not "%userID%"=="" echo %ESC%[93m%userID%%ESC%[0m
if not "%userID%"=="" set /p yesOrNot=Is this the correct steamID3[y/n]?
if not "%userID%"=="" echo.
if not "%yesOrNot%"=="y" set /p userID=Enter %ESC%[7myour new steamID3%ESC%[0m :

if "%csgoPath%"=="" echo Your csgo path
if "%csgoPath%"=="" echo.
if "%csgoPath%"=="" echo To find it : %ESC%[93m launch Steam / game's library / right click on cs:go / properties / local files / browse %ESC%[0m
if "%csgoPath%"=="" echo Your csgo path looks like C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive
if "%csgoPath%"=="" set /p csgoPath=Enter %ESC%[7myour csgo path%ESC%[0m :
if "%userID%"=="" echo.
if "%userID%"=="" echo Enter your steamID3
if "%userID%"=="" echo You can find it on https://steamidfinder.com
if "%userID%"=="" echo Your SteamID3 looks like [U:0:7355608]
if "%userID%"=="" set /p userID=Enter %ESC%[7myour SteamID3%ESC%[0m :

CALL bin\build_datas.bat

set userID="%userID:~5,-1%"
echo.& echo.the files:& echo. %ESC%[93mSteam\userdata\%userID%\730\local\cfg\video.txt %ESC%[0m& echo. %ESC%[93mSteam\userdata\%userID%\730\local\cfg\config.cfg %ESC%[0m & echo.& echo.Are going to be %ESC%[7mcopied%ESC%[0m to the current directory
set /p yesOrNot=Run?[y/n]

if "%yesOrNot%"=="y" set csgoPath=^"%csgoPath%^"
if "%yesOrNot%"=="y" set currentDir=%~dp0
if "%yesOrNot%"=="y" cd %csgoPath%

if "%yesOrNot%"=="y" xcopy /y ..\..\..\userdata\%userID%\730\local\cfg\video.txt %currentDir%\video.txt* >NUL
if not "%errorlevel%"=="0" echo %ESC%[93mSteam\userdata\%userID%\730\local\cfg\video.txt.cfg%ESC%[0m %ESC%[101mwas not found.%ESC%[0m
if "%errorlevel%"=="0" echo %ESC%[93mSteam\userdata\%userID%\730\local\cfg\video.txt%ESC%[0m %ESC%[42mwas copied without error.%ESC%[0m
if "%yesOrNot%"=="y" xcopy /y ..\..\..\userdata\%userID%\730\local\cfg\config.cfg %currentDir%\config.cfg* >NUL
if not "%errorlevel%"=="0" echo %ESC%[93mSteam\userdata\%userID%\730\local\cfg\config.cfg%ESC%[0m %ESC%[101mwas not found.%ESC%[0m
if "%errorlevel%"=="0" echo %ESC%[93mSteam\userdata\%userID%\730\local\cfg\config.cfg%ESC%[0m %ESC%[42mwas copied without error.%ESC%[0m

if not "%yesOrNot%"=="y" echo %ESC%[101mAbord...%ESC%[0m

pause
:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B 0
)

endlocal
pause
