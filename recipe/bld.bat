if "%ARCH%"=="32" (
    set PLATFORM=Win32
) else (
    set PLATFORM=x64
)


copy %RECIPE_DIR%\antlr.vcxproj lib\cpp\ || exit 1

msbuild.exe /p:Platform=%PLATFORM% /p:PlatformToolset=v140 /p:Configuration=Release lib\cpp\antlr.vcxproj
if errorlevel 1 exit 1

copy lib\cpp\x64\Release\antlr.lib %LIBRARY_LIB% || exit 1
mkdir %LIBRARY_INC%\antlr\ || exit 1
copy %SRC_DIR%\lib\cpp\antlr\*.hpp %LIBRARY_INC%\antlr\ || exit 1
