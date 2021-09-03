# ----------------------------------------------------------------------------
#
# Package               : pymake
# Version               : 0.1.1
# Source repo           : https://github.com/tqdm/pymake
# Tested on             : UBI 8.3
# Script License        : Apache License, Version 2 or later
# Passing Arguments     : Passing Arguments: 1.Version of package,
# Script License        : Apache License, Version 2 or later
# Maintainer            : Santosh Kulkarni <santoshkulkarni70@gmail.com> / Priya Seth<sethp@us.ibm.com>
#
# Disclaimer            : This script has been tested in non-root mode on given
# ==========  platform using the mentioned version of the package.
#             It may not work as expected with newer versions of the
#             package and/or distribution. In such case, please
#             contact "Maintainer" of this script.
#
# ----------------------------------------------------------------------------

#!/bin/bash

if [ -z "$1" ]; then
  export VERSION=master
else
  export VERSION=$1
fi

if [ -d "pymake" ] ; then
  rm -rf pymake
fi

# Installing Required Softwares
sudo dnf install python36 -y
sudo dnf install -y git
pip3 --version
pip3 install tox
# Downloading the git Repository
git clone https://github.com/tqdm/pymake


# Build and Test pymake
cd pymake
git checkout $VERSION

ret=$?

if [ $ret -eq 0 ] ; then
 echo "$Version found to checkout "
else
 echo "$Version not found "
 exit
fi

#Build and test with options default,simplejson,pre-commit & cover
tox -e py36-default
ret=$?
if [ $ret -ne 0 ] ; then
  echo "Build & Test failed for default"
else
  echo "Build & Test Success for default"
fi

tox -e py36-simplejson
ret=$?
if [ $ret -ne 0 ] ; then
  echo "Build & Test failed for simplejson"
else
  echo "Build & Test Success for simplejson"
fi

tox -e pre-commit
ret=$?
if [ $ret -ne 0 ] ; then
  echo "Build & Test failed for pre-commit"
else
  echo "Build & Test Success for pre-commit"
fi


tox -e cover
ret=$?
if [ $ret -ne 0 ] ; then
  echo "Build & Test failed for cover"
else
  echo "Build & Test Success for cover"
fi
