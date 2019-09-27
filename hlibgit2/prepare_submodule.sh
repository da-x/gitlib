#!/bin/bash

set -eu

if [ -e .git ]
then
    git submodule update --init --recursive
    exit 0
fi

dep=libgit2
githash=1cd0756d9566bf38db9cfadacdd5d1c31b3fd569

wget https://github.com/da-x/libgit2/archive/${githash}.tar.gz
tar xvzf ${githash}.tar.gz
mkdir -p ${dep}
mv ${dep}-${githash}/* ${dep}/
rm ${githash}.tar.gz
rm -r ${dep}-${githash}
