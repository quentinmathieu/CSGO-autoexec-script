@echo off 
cls
call bin\datas.bat
set CurrentRefreshRate=%CurrentRefreshRate:~0,-1%
set NumberOfLogicalProcessors=%NumberOfLogicalProcessors:~0,-1%
set recommanded=-console -novid -tickrate 128 -high -refresh%CurrentRefreshRate% -threads%NumberOfLogicalProcessors% -d3d9ex -nojoy +fps_max 0 +exec %name%
echo "%ESC%[93m%recommanded%%ESC%[0m"
echo.
echo %ESC%[93m-console%ESC%[0m    "Starts the game with the developer console enabled"
echo %ESC%[93m-novid%ESC%[0m      "When loading a game with this parameter, the intro Valve video will not play."
echo %ESC%[93m-tickrate%ESC%[0m   "128 sets the tick rate of any 'Offline With Bots' games, or any servers that you host via your client to 128 (as opposed to 64), usefull for stuff training"
echo %ESC%[93m-high%ESC%[0m       "It will make the CS:GO process higher priority. We recommend you try it, and if it doesn't cause issues, keep it in your launch options."
echo %ESC%[93m-high%ESC%[0m       "This set the refresh rate from your monitor refresh rate (this script get your monitor refresh rate)"
echo %ESC%[93m-threads%ESC%[0m    "This launch option sets the amount of processor threads that CS:GO will use (this script get your number of threads)"
echo %ESC%[93m-d3d9ex%ESC%[0m     "Help to 'tabs back in' more faster"
echo %ESC%[93m-nojoy%ESC%[0m      "This launch option makes the game drop all joystick support, which can decrease the amount of RAM it uses."
echo.
echo %ESC%[93m-fps_max 0%ESC%[0m  "It removes the FPS cap that is enabled by default. Most players will have turned this off, but we have included this as it will offer a benefit to anyone who hasn't."
echo.
set /p yesOrNot=Do you want to use this recommanded lauch options[y/n]?
if "%oldYesOrNot%"=="y" set replace=%recommanded%
if "%newYesOrNot%"=="y" set replace="LaunchOptions"		"%recommanded%"