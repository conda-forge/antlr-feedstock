#!/bin/bash
export MAVEN_OPTS="-Xmx1G"

cd $SRC_DIR

mvn --batch-mode versions:set -DnewVersion=${PKG_VERSION}
mvn --batch-mode --projects=runtime/Java,tool clean
mvn --batch-mode --projects=runtime/Java,tool -DskipTests install

cp "${SRC_DIR}/tool/target/antlr4-${PKG_VERSION}-complete.jar" "${PREFIX}/lib/"

echo '#!/bin/bash' > $PREFIX/bin/antlr4
echo 'java -Xmx500M -cp "'$PREFIX'/lib/antlr4-'$PKG_VERSION'-complete.jar:$CLASSPATH" org.antlr.v4.Tool "$@"' >> $PREFIX/bin/antlr4
chmod +x "${PREFIX}/bin/antlr4"

echo '#!/bin/bash' > $PREFIX/bin/grun
echo 'java -Xmx500M -cp "'$PREFIX'/lib/antlr4-'$PKG_VERSION'-complete.jar:$CLASSPATH" org.antlr.v4.gui.TestRig "$@"' >> $PREFIX/bin/grun
chmod +x "${PREFIX}/bin/grun"
