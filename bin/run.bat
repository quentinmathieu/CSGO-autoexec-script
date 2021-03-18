@echo off
set csgoPath=C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive
set userID=[U:1:109876775]
set name=autoexec.cfg
set NumberOfLogicalProcessors=12 
set CurrentRefreshRate=144 
set csgoPath=^"%csgoPath%^"
set userID=%userID:~5,9%
xcopy /y /r %name% %csgoPath%\csgo\cfg\%name%*
attrib +r %csgoPath%\csgo\cfg\%name%*
xcopy /q /y video.txt %csgoPath%\video.txt* >NUL
xcopy /q /y config.cfg %csgoPath%\config.cfg* >NUL
cd %csgoPath%
xcopy /y video.txt ..\..\..\userdata\%userID%\730\local\cfg\video.txt*
xcopy /y config.cfg ..\..\..\userdata\%userID%\730\local\cfg\config.cfg*

del video.txt
del config.cfg