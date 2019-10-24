Centos Offline Transports Utils
===============================
when you face a machine need install some packages but not
network allowed (policy or physical), this make you very frustrating
this reposity help you make this work for almost every.

**CAUTIONS** make sure you are then root user when use this

Rre-requirement
----------------
make sure you have a machine with network connnect and Cento system installed .
and two machine has the same version system installed.

usage
-----
you can download and install use the entrypoint shell ``centos-offline.sh``
currently there are four command:

.. code:: python

    download  download and tar all dependences from yum reposities. once
    install    install from downloaded tarball
    pip-download donwload pyhton packages use pip
    pip-install install from local tarball

yum download
**************
you can downlaod any package usage.
    `./centos-offline.sh download <package-name>`

it will download related rpm to `/tmp/yum-repos/<package-name>`,
create a `offline-<pakcage-name>.repo` in `/etc/yum.repos.d/`
and copy this two parts into a `<package-name>.tar.gz` in current directory
that you can use laterly to install this package in another machine wihtout
network connnect.

yum install
************
copy downloaded package tarball, and install it use:
    `./centos-offline.sh install <package-name>`

this command will reverse the process from download, also copy the related
file to `/tmp/yum-repos/<package-name>` and `/etc/yum.repos.d/`, clean up them
yourself if you don't want to keep it.

pip downlaod
*************
before you download from pypi, make sure you have `pip` isntall. if not,
`./centos-offline.sh down repl-release` and
`./centos-offline.sh download python-pip`
to install in offline-machine. **you need install them in your download
machine two, this two command not install them**

    `./centos-offline.sh pip-download <package-name>`

this will download related packages to `/tmp/pip-download/<package-name>` and
collecting them into a tar.gz compress file in current directory.

pip install
************
like yum install, reverse all process from `pip download`. make sure tarball
exists.

    `./centos-offline.sh pip-install <package-name>`
