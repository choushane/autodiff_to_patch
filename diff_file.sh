#!/bin/sh 

PATH_1=/home/shane/aximcom/ALLIS/build_dir/linux-ralink-7620_mt7620-evb
PATH_2=/home/shane/aximcom/ALLIS/build_dir/linux-ralink-7620_mt7620-als

fun_diff() {
    [ -n "$(/usr/bin/diff $1 $2)" ] && /usr/bin/diff -Naur $1 $2 > $3.patch
}

log(){
    echo "[$2] $1" >> diff.log
}

find_file(){
PATH="$(/bin/ls $1)"
for x in $PATH
do
    if [ -f "$1/$x" ]; then
        [ -f "$2/$x" ] && {
            [ "$(echo $x | /bin/grep -E "*\.c|*\.h" >> /dev/null;echo $?)" = "0" ] && fun_diff $1/$x $2/$x $x
        } || {
            log $1/$x "File"
        }
    elif [ -d "$1/$x" ]; then
        [ -d "$2/$x" ] && {
            find_file $1/$x $2/$x
        } || {
            log $1/$x "Dir"
        }
fi
done
}
find_file $PATH_1 $PATH_2
