#!/bin/sh
#
# Builds OpenBSD binaries (amd64).
#

cp -Rf changes/* trunk/

export AUTOCONF_VERSION=2.69
export AUTOMAKE_VERSION=1.15

cd trunk/src/kmk
autoreconf -i
cd ../../..

mkdir -p trunk/src/kmk/obj
cd trunk/src/kmk/obj
../configure && gmake
if [ "$?" = "0" ]; then
    cp kmk ../../../kBuild/bin/openbsd.amd64
    cp kmk_redirect ../../../kBuild/bin/openbsd.amd64
else
    echo "-> Compilation of kmk failed..."
    exit 1
fi
cd ../../../..

cp /usr/local/bin/gsed trunk/kBuild/bin/openbsd.amd64/sed
cp /usr/local/bin/bash trunk/kBuild/bin/openbsd.amd64/kmk_ash
