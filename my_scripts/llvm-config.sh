#!/bin/sh

Result = `llvm-config $* | sed -e 's/\/usr/\/usr\/x86_64-w64-mingw32/g;s/\.so/.dll/g'`
echo $Result
