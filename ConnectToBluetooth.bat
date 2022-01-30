@echo  off

rem   The following line is needed only if you haven't added Bluetooth Command Line Tools to system PATH
set PATH=C:\BTCLTools\bin;%PATH%

rem   Change the following 2 lines to match your device
set DEVICE_ADDRESS=64:31:39:64:03:D8
set SERVICE_UUID=1124

rem   If your device requires PIN code other than '0000', uncomment and change the following line
rem set PIN=1234


rem   Remove the device. Ignoring possible error here 
btpair -u -b"%DEVICE_ADDRESS%"

rem   Pair the device
btpair -p%PIN% -b"%DEVICE_ADDRESS%"
if errorlevel 1 goto error

rem   Enable the service
btcom -c -b"%DEVICE_ADDRESS%" -s%SERVICE_UUID%
if errorlevel 1 goto error

goto success

rem   Allow user to read error message before window is closed
:error
pause
exit

:success
exit