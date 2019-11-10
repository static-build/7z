#!/usr/bin/env bash
set -e

VERSION=${1:?"Provide version"} #16.02

apt update
apt install -y make curl bzip2 yasm clang-5.0 clang++-5.0 lldb-5.0 lld-5.0 upx

[ ! -e /usr/bin/clang ] && ln -s /usr/bin/clang-5.0 /usr/bin/clang
[ ! -e /usr/bin/clang++ ] && ln -s /usr/bin/clang++-5.0 /usr/bin/clang++

mkdir -p /tmp/7z
cd /tmp/7z
curl -L http://downloads.sourceforge.net/project/p7zip/p7zip/${VERSION}/p7zip_${VERSION}_src_all.tar.bz2 | tar -xj -C . --strip-components 1
cp makefile.linux_clang_amd64_asm makefile.machine
! make -j4

export A="/tmp/7z/bin/7za"
cp $A $A.upx
upx $A.upx
[ ! -z "$2" ] && cp "$A" "$2" && "$A.upx" "$2.upx"

FP="https://sourceforge.net/projects/sevenzip/files/7-Zip/${VERSION}/7z$(echo $VERSION | tr -d '.' )-x64.exe/download"
# https://sourceforge.net/projects/sevenzip/files/7-Zip/16.02/7z1602-x64.exe/download

echo $FP
wget $FP -o "/tmp/7z/bin/7za.exe"
cp  "/tmp/7z/bin/7za.exe" "/tmp/7z/bin/7za.upx.exe"
upx "/tmp/7z/bin/7za.upx.exe"
