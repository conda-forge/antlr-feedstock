if "%ARCH%"=="32" (
    set PLATFORM=Win32
) else (
    set PLATFORM=x64
)


copy %RECIPE_DIR%\antlr.vcxproj lib\cpp\ || exit 1

msbuild.exe lib\cpp\antlr.vcxproj ^
  /p:Platform=%PLATFORM% /p:Configuration=Release ^
  /p:PlatformToolset=v144 ^
  /p:CL_AdditionalOptions="/std:c++14 %(CL_AdditionalOptions)"
if errorlevel 1 exit 1

copy lib\cpp\%PLATFORM%\Release\antlr.lib %LIBRARY_LIB% || exit 1
mkdir %LIBRARY_INC%\antlr\ || exit 1
copy %SRC_DIR%\lib\cpp\antlr\*.hpp %LIBRARY_INC%\antlr\ || exit 1
