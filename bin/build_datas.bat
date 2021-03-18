@echo off
echo @echo off> bin\datas.bat
echo set csgoPath=%csgoPath%>> bin\datas.bat
echo set userID=%userID%>> bin\datas.bat
if not "%name%"=="" echo set name=%name%>> bin\datas.bat
for /f "tokens=*" %%A in ('WMIC CPU Get NumberOfLogicalProcessors /Format:List^| findstr "NumberOfLogicalProcessors"') do (echo set %%A >> bin\datas.bat)
for /f "tokens=*" %%A in ('"wmic path Win32_VideoController get CurrentRefreshRate /Format:List"') do (echo %%A >> bin\tmp.bat)
(for /f "tokens=1,* delims=:" %%A in (' findstr "CurrentRefreshRate" bin\tmp.bat') do (echo set %%A))>> bin\datas.bat

del bin\tmp.bat
::type bin\datas.bat | find /v "  " > bin\datas.bat
if not "%launchOptions%"=="" echo set launchOptions=%launchOptions%>> bin\datas.bat

