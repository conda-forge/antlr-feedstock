if "%ARCH%"=="32" (
    set PLATFORM=Win32
) else (
    set PLATFORM=x64
)


copy %RECIPE_DIR%\antlr.vcxproj lib\cpp\
if errorlevel 1 exit 1

msbuild.exe /p:Platform=%PLATFORM% /p:Configuration=Release lib\cpp\antlr.vcxproj
if errorlevel 1 exit 1
