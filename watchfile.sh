#!/bin/sh

############
# Usage
# Pass a path to watch, a file filter, and a command to run when those files are updated
#
# Example:
# watch.sh "path_towatch" "filefilter" "command to be executed"
############

watchfile() {
    WORKING_PATH=$(pwd)
    DIR=$1
    FILTER=$2
    COMMAND=$3
    chsum1=""

    while [[ true ]]
    do
        chsum2=$(find -L $WORKING_PATH/$DIR -type f -name "$FILTER" -exec md5 {} \;)
        if [[ $chsum1 != $chsum2 ]] ; then
            echo "Found a file change, executing $COMMAND..."
            $COMMAND
            chsum1=$chsum2
        fi
        sleep 2
    done
}

watchfile "$@"
