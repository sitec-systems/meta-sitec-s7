#!/bin/sh

NAND_LOAD=/dev/mtd5
NAND_STORE=/dev/mtdblock5
DEFDIR=/tmp/barebox

show_help() {
    echo "$0 [-l] [-s] [DIRECTORY]"
    echo "Options:"
    echo "  -l: Load the barebox environment from nand flash"
    echo "  -s: Store the barebox environment to the nand flash"
    echo "  DIRECTORY: Optional Directory for load and store operation (default: $DEFDIR)"
}

store=0
load=0

if [ $# -lt 1 ]; then
    echo "Not enough arugments. Try -h for help"
    exit 0
fi

while getopts "hls" opt; do
    case $opt in
        h)
            show_help
            exit 0
            ;;
        s)
            store=1
            ;;
        l)
            load=1
            ;;
        *)
            show_help
            exit 1
    esac
done

if [ $load -eq 1 -a $store -eq 1 ]; then
    echo "You need to chose wheather to store or to load the environment"
    exit 1
fi

if [ $load -eq 1 ]; then
    shift
fi

if [ $store -eq 1 ]; then
    shift
fi

usedefdir=0
if [ $# -lt 1 ]; then
    dir=$DEFDIR
    usedefdir=1
else
    dir=$1
fi

if [ ! -d $dir ]; then
    mkdir -p $dir
fi

if [ $load -eq 1 ]; then
    bareboxenv-target -l $dir $NAND_LOAD
elif [ $store -eq 1 ]; then
    cnt=$(ls -l $dir | wc -l)
    if [ $cnt -eq 0 ]; then
        echo "Your directory $dir is empty"
        exit 1
    fi
    bareboxenv-target -s $dir $NAND_STORE
    if [ $usedefdir -eq 1 ]; then
        rm -rf $dir
    fi
else
    echo "Nothing to do"
fi