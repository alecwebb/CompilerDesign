#!/bin/sh
#simple script to test compilation of provided test files
echo Converting xml to c using transform
./transform < one.xml > one.c
./transform < two.xml > two.c
./transform < three.xml > three.c
./transform < mult.xml > mult.c
echo Done
