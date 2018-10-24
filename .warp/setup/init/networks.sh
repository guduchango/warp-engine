warp_message ""
warp_message "* Configurando servicios de Red en contenedores $(warp_message_ok [ok])"
sleep 1

    cat $PROJECTPATH/.warp/setup/init/tpl/networks.yml >> $DOCKERCOMPOSEFILE

    # LOAD VARIABLES SAMPLE
    . $ENVIRONMENTVARIABLESFILESAMPLE

    if [ ! -z "$HTTP_HOST_IP" ] ; then

        A="$(echo $HTTP_HOST_IP | cut -f1 -d . )"
        B="$(echo $HTTP_HOST_IP | cut -f2 -d . )"
        C="$(echo $HTTP_HOST_IP | cut -f3 -d . )"
        
        echo "# Network information" >> $ENVIRONMENTVARIABLESFILESAMPLE
        echo "NETWORK_SUBNET=$A.$B.$C.0/24" >> $ENVIRONMENTVARIABLESFILESAMPLE
        echo "NETWORK_GATEWAY=$A.$B.$C.1" >> $ENVIRONMENTVARIABLESFILESAMPLE

        cat $PROJECTPATH/.warp/setup/init/tpl/subnet.yml >> $DOCKERCOMPOSEFILE
    fi    
