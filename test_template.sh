#!/usr/bin/env bash
if [ $1 == "2.13" ]; then
    _scala_version="2.13.6"
else if [ $1 == "2.12" ]; then
    _scala_version="2.12.13"
else
    _scala_version="2.11.12"
fi
_spinal_version=$2

do_test(){
    git clone https://github.com/SpinalHDL/SpinalTemplateSbt.git
    cd SpinalTemplateSbt
    git submodule update --init --recursive

    sed -i "s/\(val spinalVersion = \)\(\".*\"\)/\1\"${_spinal_version}\"/" build.sbt
    sed -i "s/\(scalaVersion := \)\(\".*\"\)/\1\"${_scala_version}\"/" build.sbt

    sbt compile
    sbt test
}

do_test
