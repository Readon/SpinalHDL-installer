#!/usr/bin/env bash

if [ "$1" == "2.13" ]; then
    _scala_version="2.13.6"
elif [ "$1" == "2.12" ]; then
    _scala_version="2.12.13"
else
    _scala_version="2.11.12"
fi
_spinal_version=$2

_sbt_version="1.8.0"
_newmsys="/e/msys2-install-test"
do_test(){    
    export SDKMAN_DIR=${_newmsys}/sdkman
    source $SDKMAN_DIR/bin/sdkman-init.sh
    export COURSIER_CACHE=${_newmsys}/cache/.coursier
    export SBT_OPTS="-Dsbt.version=${_sbt_version} -Dsbt.boot.directory=${_newmsys}/cache/.sbt/boot -Dsbt.global.base=${_newmsys}/cache/.sbt/1.0 -Dsbt.ivy.home=${_newmsys}/cache/.ivy2"
    export SBT_CMD="${SDKMAN_DIR}/candidates/sbt/current/bin/sbt ${SBT_OPTS}"

    git clone https://github.com/SpinalHDL/SpinalTemplateSbt.git
    cd SpinalTemplateSbt || exit
    git submodule update --init --recursive

    sed -i "s/\(val spinalVersion = \)\(\".*\"\)/\1\"${_spinal_version}\"/" build.sbt
    sed -i "s/\(scalaVersion := \)\(\".*\"\)/\1\"${_scala_version}\"/" build.sbt

    ${SBT_CMD} -Dsbt.offline=true compile
    ${SBT_CMD} -Dsbt.offline=true test
}

do_test
