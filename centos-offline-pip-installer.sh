#!/bin/bash

if [[ $# < 1 ]]; then
    echo "package name must supply"
fi
pkg_name=$1
pkg_path=/tmp/pip-download/$pkg_name
tar -xf pip-$pkg_name.tar.gz -C /
pip install --no-index --find-links=$pkg_path $pkg_name
