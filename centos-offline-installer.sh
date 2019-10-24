#!/bin/bash

if [[ $# < 1 ]]; then
    echo "package name must supplied"
    exit 1
fi

pkg_name=$1
pkg_tarball=${pkg_name}.tar.gz
if [[ ! -f $pkg_tarball ]]; then
    echo "tarball not found, make sure run this script in directory with download rmps tarball"
    exit 1
fi

# extract to right place
tar -xf $pkg_tarball -C /

# run
yum --disablerepo=\* --enablerepo=offline-$pkg_name install $pkg_name

# if this not work you can use command below
# rpm -ivh --replacefiles --replacepkgs *.rpm
