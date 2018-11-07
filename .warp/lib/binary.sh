#!/bin/bash

function warp_binary_create()
{
    # CREATE BINARY FILE

    sudo touch $WARP_BINARY_FILE
    sudo chmod 775 $WARP_BINARY_FILE
    sudo echo "#\!/bin/bash +x" >> $WARP_BINARY_FILE
    sudo echo "" >> $WARP_BINARY_FILE
    sudo echo "sh ./warp \"\$@\"" >> $WARP_BINARY_FILE
}
