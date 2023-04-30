#! /bin/bash

lix dev hollywoo-flixel .
(cd src/test && lix run lime test neko -debug)
