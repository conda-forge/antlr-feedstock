if "%ARCH%"=="32" (
    set PLATFORM=Win32
) else (
    set PLATFORM=x64
)

copy %RECIPE_DIR%/antlr.vcxproj .
msbuild.exe /p:Platform=%PLATFORM% /p:Configuration=Release antlr.vcxproj
