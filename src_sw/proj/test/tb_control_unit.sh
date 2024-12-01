#!/bin/bash
target=tb_control_unit
# make sure parent folder is `test`
parent_path=$( cd "$(dirname "$0")" ; pwd -P )
echo "parent_path: $parent_path"
# split to the last '/'
last_slash=$(echo "$parent_path" | rev | cut -d'/' -f1 | rev)
echo "last_slash: $last_slash"
if [ "$last_slash" != "test" ]; then
    echo "Error: parent folder is not 'test'. Trying to move there..."
    cd proj/test || echo "Error: could not move to 'proj/test'" && exit 1
fi

export PATH=$PATH:/usr/local/mentor/questasim/bin
export SALT_LICENSE_SERVER=$SALT_LICENSE_SERVER:1717@io.ece.iastate.edu
/usr/local/mentor/questasim/bin/vsim -do "sleep 3; do ./$target.do" .
