REM ---- Copy File to Staging 01/15/2021-------
REM ---  source and destination and Log path ----
set sourcePath=\\RSFP5CG0432G89\c$\fg\deployment
set destinationServer1=\\RSFP5CG0432G89\c$\CSRQ\src\components\layout
set destinationServer2=\\RSFP5CG0432G89\c$\fg
set logPath="\\RSFP5CG0432G89\c$\fg\Deploylogs
REM ===========================================================
ECHO --- Start Copying Files -----------------    >> %logPath%
Cmd/C xcopy %sourcePath%\*.*       %destinationServer1%\*.*  /E /Y /F 
rem Cmd/C xcopy %sourcePath%\RSApplications\*.*       %destinationServer2%\RSApplications\*.*  /E /Y /F 
rem pause
