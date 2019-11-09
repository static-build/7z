#!/usr/bin/env bash
set -e

VERSION=${1:?"Provide version"} #16.02

apt update
apt install -y make curl bzip2 yasm clang-5.0 clang++-5.0 lldb-5.0 lld-5.0

[ ! -e /usr/bin/clang ] && ln -s /usr/bin/clang-5.0 /usr/bin/clang
[ ! -e /usr/bin/clang++ ] && ln -s /usr/bin/clang++-5.0 /usr/bin/clang++

mkdir -p /tmp/7z
cd /tmp/7z
curl -L http://downloads.sourceforge.net/project/p7zip/p7zip/${VERSION}/p7zip_${VERSION}_src_all.tar.bz2 | tar -xj -C . --strip-components 1
cp makefile.linux_clang_amd64_asm makefile.machine
! make -j4

export A="/tmp/7z/bin/7za"
[ ! -z "$2" ] && cp "$A" "$2"
