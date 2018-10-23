warp_message_info "Configurando un servicio de Red interno"

    echo ""

    network_subnet=$( warp_question_ask_default "Ingrese un rango de IP para la Subnet Interna de los contenedores: $(warp_message_info [172.50.0.0/24]) " "172.50.0.0/24" )
    warp_message_info2 "Subnet Seleccionada: $network_subnet"

    network_gateway=$( warp_question_ask_default "Ingrese un gateway de IP para la Subnet de los contenedores: $(warp_message_info [172.50.0.1]) " "172.50.0.1" )
    warp_message_info2 "Gateway Seleccionada: $network_gateway"

    network_name=$( warp_question_ask_default "Elija un nombre para la Red Interna: $(warp_message_info [SummaNET]) " "SummaNET" )
    warp_message_info2 "Nombre de Red seleccionado: $network_name"

    echo "# Network information" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "NETWORK_NAME=$network_name" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "NETWORK_SUBNET=$network_subnet" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "NETWORK_GATEWAY=$network_gateway" >> $ENVIRONMENTVARIABLESFILESAMPLE

#cat $PROJECTPATH/.warp/setup/init/tpl/networks.yml >> $DOCKERCOMPOSEFILE