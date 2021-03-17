@echo off
echo @echo off> bin\datas.bat
echo set csgoPath=%csgoPath%>> bin\datas.bat
echo set userID=%userID%>> bin\datas.bat
if not "%name%"=="" echo set name=%name%>> bin\datas.bat
if not "%NumberOfLogicalProcessors%"=="" echo set NumberOfLogicalProcessors=%NumberOfLogicalProcessors%>> bin\datas.bat
if "%NumberOfLogicalProcessors%"=="" for /f "tokens=*" %%A in ('WMIC CPU Get /Format:List ^| findstr "NumberOfLogicalProcessors"') do (echo set %%A >> bin\datas.bat)
if not "%launchOptions%"=="" echo set launchOptions=%launchOptions%>> bin\datas.bat
