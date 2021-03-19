@echo off 
cls
call bin\datas.bat
set recommanded=-console -novid -tickrate 128 -high -refresh%CurrentRefreshRate% -threads%NumberOfLogicalProcessors% -d3d9ex -nojoy +exec %name%
echo There are the recommanded options for your pc :
echo "%ESC%[93m%recommanded%%ESC%[0m"
echo.
echo %ESC%[36m-console%ESC%[0m    "Starts the game with the developer console enabled"
echo %ESC%[36m-novid%ESC%[0m      "When loading a game with this parameter, the intro Valve video will not play."
echo %ESC%[36m-tickrate%ESC%[0m   "128 sets the tick rate of any 'Offline With Bots' games, or any servers that you host via your client to 128 (as opposed to 64), usefull for stuff training"
echo %ESC%[36m-high%ESC%[0m       "It will make the CS:GO process higher priority. We recommend you try it, and if it doesn't cause issues, keep it in your launch options."
echo %ESC%[36m-refresh%ESC%[0m       "This set the refresh rate from your monitor refresh rate (this script get your monitor refresh rate)"
echo %ESC%[36m-threads%ESC%[0m    "This launch option sets the amount of processor threads that CS:GO will use (this script get your number of threads)"
echo %ESC%[36m-d3d9ex%ESC%[0m     "Help to 'tabs back in' more faster"
echo %ESC%[36m-nojoy%ESC%[0m      "This launch option makes the game drop all joystick support, which can decrease the amount of RAM it uses."
echo.
:recommandedOptions
set /p recommandYesOrNot=Do you want to use this recommanded launch options[y/n]?
if "%recommandYesOrNot%"=="y" goto recommandYes
if "%recommandYesOrNot%"=="n" goto askCustom
if not "%recommandYesOrNot%"=="y" if not "%recommandYesOrNot%"=="n" echo.& echo.%ESC%[41mBad input, retry%ESC%[0m & goto :recommandedOptions

:recommandYes
if "%oldYesOrNot%"=="y" echo.& echo.%ESC%[42mYour launch options haven been set to :%ESC%[0m & echo.%ESC%[93m"%recommanded%"%ESC%[0m& set replace=%recommanded%
if "%newYesOrNot%"=="y" echo.& echo.%ESC%[42mYour launch options haven been set to :%ESC%[0m & echo.%ESC%[93m"%recommanded%"%ESC%[0m& set replace=%recommanded%
goto end

:askCustom
set /p customYesOrNot=Do you want to input custom lauch options[y/n]?
if "%customYesOrNot%"=="y" goto cumstomYes
if "%customYesOrNot%"=="n" goto customNo
if not "%customYesOrNot%"=="y" if not "%customYesOrNot%"=="n" echo.& echo.%ESC%[41mBad input, retry%ESC%[0m& goto :recommandedOptions

:cumstomYes
set /p customInput=Enter your custom launch options:
echo.& echo.%ESC%[42mYour launch options haven been set to :%ESC%[0m & echo.%ESC%[93m"%customInput%"%ESC%[0m& set replace=%customInput%

:customNo
if "%oldYesOrNot%"=="y" echo.& echo.%ESC%[43mLaunch options haven't been update%ESC%[0m& set replace=%launchOptions%& goto end
if "%newYesOrNot%"=="y" echo.& echo.%ESC%[42mYour launch options haven been set to %ESC%[93m"+exec %name%"%ESC%[0m& set replace=+exec %name%& goto end

:end