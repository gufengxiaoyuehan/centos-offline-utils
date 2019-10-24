#!/bin/bash

function print_help(){
    echo "./centos-offline.sh cmd package"
    echo "this script usage to install/download rpm binary files"
    echo "      cmd:"
    echo "          download --  download related rpm packages to a tarbar used in offline enviroment"
    echo "          install -- install from the tarball created from download command"
    echo "      package: "
    echo "              package name to be installed or downloaded"
}

if [[ $# < 2 ]]; then
    print_help
    exit 1
fi

cmd=$1
shift

case $cmd in
    download)
        . ./centos-offline-downloader.sh $@
        ;;
    install)
        . ./centos-offline-installer.sh $@
        ;;
    pip-download)
        . ./centos-offline-pip-downloader.sh $@
        ;;
    pip-install)
        . ./centos-offline-pip-installer.sh $@
        ;;
    *)
        print_help
        ;;
esac

