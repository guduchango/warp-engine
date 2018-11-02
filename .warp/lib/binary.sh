#!/bin/bash

function warp_binary_create()
{
    # CREATE BINARY FILE

    echo "#\!/bin/bash +x" > $WARP_BINARY_FILE
    echo "" >> $WARP_BINARY_FILE
    echo "sh ./warp \"\$@\"" >> $WARP_BINARY_FILE
    chmod +x $WARP_BINARY_FILE
}
