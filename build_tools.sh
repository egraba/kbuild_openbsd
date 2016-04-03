#!/bin/sh
#
# Builds all tools.
#

compile()
{

}

copy_binaries()
{
    cp -f ../../out/openbsd.amd64/release/stage/kBuild/bin/openbsd.amd64/* ../../../../kBuild/bin/openbsd.amd64
}

cd trunk/src

#
# lib
#
cd lib
kmk
if [ "$?" = "0" ]; then
    echo "--> Compilation of lib succeeded!"
else
    echo "--> Compilation of lib failed..."
    exit 1
fi
cd ..

#
# kmk
#
cd kmk
kmk CP=/bin/cp
if [ "$?" = "0" ]; then
    echo "--> Compilation of kmk succeeded!"
    copy_binaries
else
    echo "--> Compilation of kmk failed..."
    exit 1
fi
# kmk has to be recompiled with generated kmk.
kmk clean
kmk
if [ "$?" = "0" ]; then
    echo "--> Recompilation of kmk succeeded!"
    copy_kmk_binaries
else
    echo "--> Recompilation of kmk failed..."
    exit 1
fi
cd ..

#
# kash
#
cd kash
kmk
if [ "$?" = "0" ]; then
    echo "--> Compilation of kash succeeded!"
    copy_binaries
else
    echo "--> Compilation of kash failed..."
    exit 1
fi
kmk clean
kmk
if [ "$?" = "0" ]; then
    echo "--> Recompilation of kash succeeded!"
    copy_binaries
else
    echo "--> Recompilation of kash failed..."
    exit 1
fi
cd ..
