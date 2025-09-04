@echo on
setlocal EnableExtensions

set "PLATFORM=x64"

rem VS environment
call "%VSINSTALLDIR%VC\Auxiliary\Build\vcvars64.bat"

rem Exact Windows SDK version (e.g., 10.0.26100.0)
set "SDKVER=%WindowsSDKVersion%"
if defined SDKVER (
  set "SDKVER=%SDKVER:\=%"
  if "%SDKVER:~-1%"=="\" set "SDKVER=%SDKVER:~0,-1%"
) else set "SDKVER=10.0"

copy "%RECIPE_DIR%\antlr.vcxproj" "lib\cpp\" || exit 1

msbuild.exe lib\cpp\antlr.vcxproj ^
  /m ^
  /p:Platform=%PLATFORM% ^
  /p:Configuration=Release ^
  /p:PlatformToolset=v143 ^
  /p:WindowsTargetPlatformVersion=%SDKVER% ^
  /p:PreferredToolArchitecture=x64
if errorlevel 1 exit 1

if not exist "%LIBRARY_LIB%" mkdir "%LIBRARY_LIB%"
if not exist "%LIBRARY_INC%\antlr" mkdir "%LIBRARY_INC%\antlr"

copy /y "lib\cpp\build\%PLATFORM%\Release\antlr.lib" "%LIBRARY_LIB%\antlr.lib" || exit 1
copy /y "%SRC_DIR%\lib\cpp\antlr\*.h"   "%LIBRARY_INC%\antlr\" || exit 1
copy /y "%SRC_DIR%\lib\cpp\antlr\*.hpp" "%LIBRARY_INC%\antlr\" || exit 1

endlocal
