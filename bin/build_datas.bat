@echo off
echo @echo off> bin\datas.bat
echo set csgoPath=%csgoPath%>> bin\datas.bat
echo set userID=%userID%>> bin\datas.bat
if not "%name%"=="" echo set name=%name%>> bin\datas.bat
for /f "tokens=1*" %%A in ('WMIC CPU Get NumberOfLogicalProcessors /Format:List^| findstr /r /v "^$"') do (echo set %%A>> bin\datas.bat)
for /f "tokens=1*" %%A in ('WMIC path Win32_VideoController get CurrentRefreshRate /Format:List^| findstr /r /v "^$"') do (echo set %%A>> bin\datas.bat)
if not "%launchOptions%"=="" echo set launchOptions=%launchOptions%>> bin\datas.bat

