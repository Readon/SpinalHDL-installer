declare -A full_scala_versions
full_scala_versions["2.11-1.6.4"]="2.11.12"
full_scala_versions["2.12-1.6.4"]="2.12.18"
full_scala_versions["2.13-1.6.4"]="2.13.6"

full_scala_versions["2.11-1.7.3a"]="2.11.12"
full_scala_versions["2.12-1.7.3a"]="2.12.18"
full_scala_versions["2.13-1.7.3a"]="2.13.6"

full_scala_versions["2.11-1.8.2"]="2.11.12"
full_scala_versions["2.12-1.8.2"]="2.12.13"
full_scala_versions["2.13-1.8.2"]="2.13.6"

full_scala_versions["2.11-1.9.3"]="2.11.12"
full_scala_versions["2.12-1.9.3"]="2.12.13"
full_scala_versions["2.13-1.9.3"]="2.13.6"

full_scala_versions["2.11-1.9.4"]="2.11.12"
full_scala_versions["2.12-1.9.4"]="2.12.18"
full_scala_versions["2.13-1.9.4"]="2.13.12"

full_scala_versions["2.11-1.10.1"]="2.11.12"
full_scala_versions["2.12-1.10.1"]="2.12.18"
full_scala_versions["2.13-1.10.1"]="2.13.12"

full_scala_versions["2.11-1.10.2a"]="2.11.12"
full_scala_versions["2.12-1.10.2a"]="2.12.18"
full_scala_versions["2.13-1.10.2a"]="2.13.12"

full_scala_versions["2.11-1.11.0"]="2.11.12"
full_scala_versions["2.12-1.11.0"]="2.12.18"
full_scala_versions["2.13-1.11.0"]="2.13.12"

full_scala_versions["2.11-1.12.2"]="2.11.12"
full_scala_versions["2.12-1.12.2"]="2.12.18"
full_scala_versions["2.13-1.12.2"]="2.13.12"

_sbt_version="1.8.0"
_java_version="17.0.8.1-tem"

_yosys_major_version="0.41"

is_version_smaller_eq() {
    arg1=$1
    arg2=$2
    small_one=$(echo -e "${arg1}\n${arg2}" | sort -V | head -n 1)
    if [ $small_one == $arg1 ]; then
        echo "true"
    else
        echo "false"
    fi
}