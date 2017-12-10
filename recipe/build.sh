#!/bin/bash
export MAVEN_OPTS="-Xmx1G"

mvn --projects=tool clean
mvn --projects=tool -DskipTests install

cp "${SRC_DIR}/tool/target/antlr4-${PKG_VERSION}-complete.jar" "${PREFIX}/lib/"

"${PYTHON}" "${RECIPE_DIR}/make_wrapper.py"
chmod +x "${PREFIX}/bin/antlr4"
