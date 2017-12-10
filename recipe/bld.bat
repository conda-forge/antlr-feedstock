set MAVEN_OPTS="-Xmx1G"

REM cmd.exe /c mvn --projects=tool clean || echo ""
cmd.exe /c mvn --projects=tool -DskipTests install || echo ""

copy "%SRC_DIR%\tool\target\antlr4-%PKG_VERSION%-complete.jar" "%LIBRARY_LIB%\"

"%PYTHON%" "%RECIPE_DIR%\make_wrapper.py"
