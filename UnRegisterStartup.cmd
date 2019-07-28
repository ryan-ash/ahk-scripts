@echo off
cd /D "%~dp0"

set LINK=%userprofile%\Start Menu\Programs\Startup\Discord Quote Extension.lnk
del "%LINK%" /q /f
