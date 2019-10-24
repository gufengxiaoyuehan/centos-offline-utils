#!/bin/bash

echo "makre sure you use root user"
# make tmp file to save the download
if [[ $# < 1 ]]; then
    echo "package name must supplied"
    exit
fi

set -e

pkg_name=$1

# add repo if needed
case $pkg_name in
    docker-ce)
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    ;;
esac

echo "which release version you want to donwlaod[you can check is by 'cat /etc/centos-release']"
read release_version

default_release=$(cat /etc/centos-release | sed -r 's/.*([0-9])\.[0-9]*.*/\1/')
release_version=${release_version:-$default_release}
echo "current release version is $release_version, set it to download resleaserver"

yum update -y && yum install -y yum-plugin-downloadonly yum-utils createrepo

download_dir=/tmp/yum-repos/$pkg_name
downlaod_root_dir=/tmp/yum-repos/$pkg_name-installroot
mkdir -p $download_dir
mkdir -p $downlaod_root_dir

# download all dependencies' RPMs
yum install --downloadonly --installroot=$downlaod_root_dir --releasever=$release_version  --downloaddir=$download_dir $pkg_name

# generate the metadata need to turn our new pile of RPMs into a YUM repo
createrepo --database $download_dir
# clean up things we don't need
rm -rf $downlaod_root_dir

repo_path=/etc/yum.repos.d/offline-$pkg_name.repo

cat > $repo_path <<EOF
[offline-$pkg_name]
name=CentOS-\$releaserver - $pkg_name
baseurl=file://$download_dir
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$release_version

EOF

# check the missing dependenceis
repoclosure --repoid=offline-$pkg_name

# make a tarball to transport
echo "generate yum repo, copy them to dest machine and install it"
tar -cvzf $pkg_name.tar.gz $download_dir $repo_path


