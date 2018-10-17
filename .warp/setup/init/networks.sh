warp_message_info "Configurando un servicio de Red interno"

    echo ""
    network_subnet=$( warp_question_ask_default "Elija un rango de IP para la Subnet Interna de los contenedores: $(warp_message_info [172.20.0.0/16]) " "172.20.0.0/16" )
    warp_message_info2 "Subnet Seleccionada: $network_subnet"
    network_name=$( warp_question_ask_default "Elija un nombre para la Red Interna: $(warp_message_info [SummaNET]) " "SummaNET" )
    warp_message_info2 "Nombre de Red seleccionado: $network_name"

    echo "# Network information" >> $PROJECTPATH/.env
    echo "NETWORK_NAME=$network_name" >> $PROJECTPATH/.env
    echo "NETWORK_SUBNET=$network_subnet" >> $PROJECTPATH/.env

cat $PROJECTPATH/.warp/setup/init/tpl/networks.yml >> $PROJECTPATH/docker-compose.yml