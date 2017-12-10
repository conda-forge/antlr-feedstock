set MAVEN_OPTS="-Xmx1G"

cmd.exe /c mvn --projects=tool clean || echo ""
cmd.exe /c mvn --projects=tool -DskipTests install || echo ""

copy "%SRC_DIR%\tool\target\antlr4-%PKG_VERSION%-complete.jar" "%LIBRARY_LIB%\"
echo java -Xmx500M -cp %LIBRARY_LIB%\\antlr4-%PKG_VERSION%-complete.jar;%%CLASSPATH%% org.antlr.v4.Tool %* > %LIBRARY_BIN%\antlr4.cmd
echo IF %%ERRORLEVEL%% NEQ 0 EXIT /B %%ERRORLEVEL%% >> %LIBRARY_BIN%\antlr4.cmd
