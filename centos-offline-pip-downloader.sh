#!/bin/bash

if [[ $# < 1 ]]; then
    echo "package name must supply"
fi
pkg_name=$1
pkg_path=/tmp/pip-download/$pkg_name
mkdir -p $pkg_path
pip download -d $pkg_path $pkg_name

tar -cvzf pip-$pkg_name.tar.gz $pkg_path
