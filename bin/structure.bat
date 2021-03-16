set csgoPath=^"%csgoPath%^"
xcopy /y /r %name% %csgoPath%\csgo\cfg\%name%*
attrib +r %csgoPath%\csgo\cfg\%name%*
xcopy /q /y video.txt %csgoPath%\video.txt* >NUL
xcopy /q /y config.cfg %csgoPath%\config.cfg* >NUL
cd %csgoPath%
xcopy /y video.txt ..\..\..\userdata\%userID%\730\local\cfg\video.txt*
xcopy /y config.cfg ..\..\..\userdata\%userID%\730\local\cfg\config.cfg*

del video.txt
del config.cfg