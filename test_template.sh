#!/usr/bin/env bash
_scala_version="$1"
_spinal_version="$2"

_dir=$(dirname $0)
source ${_dir}/get_versions.sh
_index="${_scala_version}-${_spinal_version}"
_scala_full_version=${full_scala_versions[${_index}]}

_sbt_version="1.8.0"
_newmsys="/c/msys2-install-test"
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
    sed -i "s/\(scalaVersion := \)\(\".*\"\)/\1\"${_scala_full_version}\"/" build.sbt

    ${SBT_CMD} -Dsbt.offline=true "compile" || exit
    ${SBT_CMD} -Dsbt.offline=true "runMain projectname.MyTopLevelVerilog" || exit
    ${SBT_CMD} -Dsbt.offline=true "runMain projectname.MyTopLevelVhdl" || exit
    ${SBT_CMD} -Dsbt.offline=true "runMain projectname.MyTopLevelSim" || exit
    ${SBT_CMD} -Dsbt.offline=true "runMain projectname.MyTopLevelFormal" || exit
    ${SBT_CMD} -Dsbt.offline=true "test" || exit

    cd ..
}

do_test
