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

rem --- Sanity check: the ANTLR2 runtime sources must be here:
echo Listing %SRC_DIR%\lib\cpp\src
dir /b "%SRC_DIR%\lib\cpp\src" || echo (dir failed)

if not exist "%SRC_DIR%\lib\cpp\src\ANTLRUtil.cpp" (
  echo ERROR: Missing runtime sources under %SRC_DIR%\lib\cpp\src
  echo Showing what exists under %SRC_DIR%\lib\cpp:
  dir /s /b "%SRC_DIR%\lib\cpp"
  exit /b 1
)

copy "%RECIPE_DIR%\antlr.vcxproj" "%SRC_DIR%\lib\cpp\" || exit 1

pushd "%SRC_DIR%\lib\cpp"

msbuild.exe "antlr.vcxproj" ^
  /m ^
  /p:Platform=%PLATFORM% ^
  /p:Configuration=Release ^
  /p:PlatformToolset=v143 ^
  /p:WindowsTargetPlatformVersion=%SDKVER% ^
  /p:PreferredToolArchitecture=x64
if errorlevel 1 exit 1
popd

if not exist "%LIBRARY_LIB%" mkdir "%LIBRARY_LIB%"
if not exist "%LIBRARY_INC%\antlr" mkdir "%LIBRARY_INC%\antlr"

copy /y "%SRC_DIR%\lib\cpp\build\%PLATFORM%\Release\antlr.lib" "%LIBRARY_LIB%\antlr.lib" || exit 1
copy /y "%SRC_DIR%\lib\cpp\antlr\*.hpp" "%LIBRARY_INC%\antlr\" || exit 1

endlocal
