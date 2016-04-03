#!/bin/sh
#
# Builds all tools.
#

compile()
{
    cd $1
    if [ "$1" = "kmk" ]; then
	kmk CP=/bin/cp
    else
	kmk
    fi
    if [ "$?" = "0" ]; then
	echo "--> Compilation of $1 succeeded!"
	copy_binaries
    else
	echo "--> Compilation of $1 failed..."
	exit 1
    fi
    # Every tool has to be recompiled with generated binaires.
    kmk clean
    kmk
    if [ "$?" = "0" ]; then
	echo "--> Recompilation of $1 succeeded!"
	copy_binaries
    else
	echo "--> Recompilation of $1 failed..."
	exit 1
    fi
    cd ..
}

copy_binaries()
{
    cp -f ../../out/openbsd.amd64/release/stage/kBuild/bin/openbsd.amd64/* ../../kBuild/bin/openbsd.amd64
}

cd trunk/src
compile lib
compile kmk
compile kash
