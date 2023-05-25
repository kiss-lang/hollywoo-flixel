#! /bin/bash

target=${1:-cpp}

cp -rf haxe_libraries src/test/
(cd src/test && lix dev hollywoo-flixel ../../ && lix download && lix run lime test $target -debug)