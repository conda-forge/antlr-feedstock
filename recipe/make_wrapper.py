import platform
import os
from os.path import join


PKG_VERSION = os.environ["PKG_VERSION"]

SHELL_CONTENT = """#!/bin/bash
java -Xmx500M -cp "$CONDA_PREFIX/lib/antlr4-%s-complete.jar:$CLASSPATH" org.antlr.v4.Tool "$@"
""" % PKG_VERSION

BAT_CONTENT = """
java -Xmx500M -cp %CONDA_PREFIX%\\Library\\lib\\antlr4-{}-complete.jar;%CLASSPATH% org.antlr.v4.Tool %*
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%
""".format(PKG_VERSION)


def make_wrapper():
    content = SHELL_CONTENT
    filename = join(os.environ["PREFIX"], "bin", "antlr4")

    if platform.system() == "Windows":
        content = BAT_CONTENT
        filename = join(os.environ["SCRIPTS"], "antlr4.cmd")

    with open(filename, "w+") as fp:
        fp.write(content)


if __name__ == "__main__":
    make_wrapper()
