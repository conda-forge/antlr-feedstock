#!/bin/bash
export MAVEN_OPTS="-Xmx1G"

cd $SRC_DIR/runtime/Java

mvn --batch-mode clean
mvn --batch-mode install

cd $SRC_DIR

mvn --batch-mode --projects=tool clean
mvn --batch-mode --projects=tool -DskipTests install

cp "${SRC_DIR}/tool/target/antlr4-${PKG_VERSION}-complete.jar" "${PREFIX}/lib/"

echo '#!/bin/bash' > $PREFIX/bin/antlr4
echo 'java -Xmx500M -cp "'$PREFIX'/lib/antlr4-'$PKG_VERSION'-complete.jar:$CLASSPATH" org.antlr.v4.Tool "$@"' >> $PREFIX/bin/antlr4
chmod +x "${PREFIX}/bin/antlr4"
