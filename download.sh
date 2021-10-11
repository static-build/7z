#! /usr/bin/env bash

if [ ! -f bin/7za.exe ]; then
    (
        [ -f tmp/7z.win.7z ] || wget https://www.7-zip.org/a/7z1900-extra.7z -O tmp/7z.win.7z
        mkdir -p tmp/7z.win/; cd tmp/7z.win/
        7z -y x ../7z.win.7z
    )
    cp  tmp/7z.win/7za.exe                      bin/7za.exe
    # cp  tmp/7z.win/7zr.exe                      bin/7zr.exe

    cp  tmp/7z.win/x64/7za.exe                  bin/7za.x64.exe
    # cp  tmp/7z.win/x64/7zr.exe                  bin/7zr.x64.exe
fi

if [ ! -f bin/7za.linux.x86 ]; then
    (
        [ -f tmp/7z.linux.tar.bz2 ] || wget https://sourceforge.net/projects/p7zip/files/p7zip/16.02/p7zip_16.02_x86_linux_bin.tar.bz2/download -O tmp/7z.linux.tar.bz2
        mkdir -p tmp/7z.linux.x86/; cd tmp/7z.linux.x86/
        tar xvf ../7z.linux.tar.bz2
    )
    cp  tmp/7z.linux.x86/p7zip_16.02/bin/7za     bin/7za.linux.x86
    7z  bin/7za.linux.x86.7z                     bin/7za.linux.x86

    cp  tmp/7z.linux.x86/p7zip_16.02/bin/7zd     bin/7zd.linux.x86
    # TODO: 
    upx bin/7zd.linux.x86

fi
