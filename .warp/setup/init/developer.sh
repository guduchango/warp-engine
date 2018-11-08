#!/bin/bash +x

# INIT PROJECTS MODE DEVELOPER

    # - Check .warp folder
    # - Check yml
    # - .env.sample
    # - ! .env

[ ! -f $ENVIRONMENTVARIABLESFILE ] && cp $ENVIRONMENTVARIABLESFILESAMPLE $ENVIRONMENTVARIABLESFILE
[ ! -f $DOCKERCOMPOSEFILE ] && cp $DOCKERCOMPOSEFILESAMPLE $DOCKERCOMPOSEFILE

    # LOAD VARIABLES SAMPLE
    . $ENVIRONMENTVARIABLESFILESAMPLE

warp_message ""
warp_message_info "Configurando el Servidor Web - Nginx"
warp_message ""

    warp_check_os_mac

    useproxy=1 #False

    case "$(uname -s)" in
        Linux)
            resp_reverse_proxy=$( warp_question_ask_default "Queres configurar una ip estatica para soportar mas de un proyecto en paralelo? $(warp_message_info [y/N]) " "N" )
            if [ "$resp_reverse_proxy" = "Y" ] || [ "$resp_reverse_proxy" = "y" ]
            then
                # autodetect docker in linux
                useproxy=0 #True
            fi;
        ;;
    esac

    if [ $useproxy = 1 ]; then
        while : ; do
            http_port=$( warp_question_ask_default "Mapeo del puerto 80 del contenedor al puerto de tu maquina (host)? $(warp_message_info [80]) " "80" )

            #CHECK si port es numero antes de llamar a warp_net_port_in_use
            if ! warp_net_port_in_use $http_port ; then
                warp_message_info2 "El puerto seleccionado es: $http_port, la configuracion para el archivo /etc/hosts es: $(warp_message_bold '127.0.0.1 '$VIRTUAL_HOST)"
                break
            else
                warp_message_warn "El puerto $http_port esta ocupado, elige otro\n"
            fi;
        done

        while : ; do
            https_port=$( warp_question_ask_default "Mapeo del puerto 443 del contenedor al puerto de tu maquina (host)? $(warp_message_info [443]) " "443" )

            if ! warp_net_port_in_use $https_port ; then
                warp_message_info2 "El puerto seleccionado es: $https_port, la configuracion para el archivo /etc/hosts es: $(warp_message_bold '127.0.0.1 '$VIRTUAL_HOST)"
                break
            else
                warp_message_warn "El puerto $https_port esta ocupado, elige otro\n"
            fi;
        done
    else 
        while : ; do
            http_container_ip=$( warp_question_ask_default "Ingrese numero de IP para asignar al contenedor? $(warp_message_info '[rango 172.50.0.'$MIN_RANGE_IP' - 172.50.0.255]') " "172.50.0.$MIN_RANGE_IP" )

            if warp_check_range_ip $http_container_ip ; then
                RANGE=$(echo $http_container_ip | cut -f1 -f2 -f3 -d .)
                warp_message_warn "Debe seleccionar una IP entre: $RANGE.$MIN_RANGE_IP y $RANGE.255\n"
            else 
                if ! warp_net_ip_in_use $http_container_ip ; then
                    warp_message_info2 "La IP seleccionada es: $http_container_ip, la configuracion para el archivo /etc/hosts es: $(warp_message_bold $http_container_ip' '$VIRTUAL_HOST)"
                    break
                else
                    warp_message_warn "La IP $http_container_ip esta ocupada en otro proyecto, elija otra\n"
                fi;
            fi;
        done
    fi; 

    warp_message ""
    warp_message_info "Configurando el Servicio de MySQL"
    warp_message ""

    while : ; do
        mysql_binded_port=$( warp_question_ask_default "Mapeo del puerto 3306 del contenedor al puerto de tu maquina (host)? $(warp_message_info [3306]) " "3306" )

        #CHECK si port es numero antes de llamar a warp_net_port_in_use
        if ! warp_net_port_in_use $mysql_binded_port ; then
            warp_message_info2 "El puerto seleccionado es: $mysql_binded_port, el mapeo de puertos es: $(warp_message_bold '127.0.0.1:'$mysql_binded_port' ---> localhost:'$mysql_binded_port)"
            break
        else
            warp_message_warn "El puerto $mysql_binded_port esta ocupado, elige otro\n"
        fi;
    done

    HTTP_HOST_OLD="HTTP_HOST_IP=$HTTP_HOST_IP"
    HTTP_BINDED_OLD="HTTP_BINDED_PORT=$HTTP_BINDED_PORT"
    HTTPS_BINDED_OLD="HTTPS_BINDED_PORT=$HTTPS_BINDED_PORT"

    N1="$(echo $NETWORK_SUBNET | cut -f1 -d / )" 
    N2="$(echo $NETWORK_SUBNET | cut -f2 -d / )" 
    NETWORK_SUBNET_OLD="NETWORK_SUBNET=$N1\/$N2"
    NETWORK_GATEWAY_OLD="NETWORK_GATEWAY=$NETWORK_GATEWAY"

    if [ $useproxy = 0 ]; then
        # Cambia IP a multi-proyecto

        HTTP_HOST_NEW="HTTP_HOST_IP=$http_container_ip"
        HTTP_BINDED_NEW="HTTP_BINDED_PORT=80"
        HTTPS_BINDED_NEW="HTTPS_BINDED_PORT=443"

        # Modify Gateway and Subnet

        A="$(echo $http_container_ip | cut -f1 -d . )"
        B="$(echo $http_container_ip | cut -f2 -d . )"
        C="$(echo $http_container_ip | cut -f3 -d . )"
        
        NETWORK_SUBNET_NEW="NETWORK_SUBNET=$A.$B.$C.0\/24"
        NETWORK_GATEWAY_NEW="NETWORK_GATEWAY=$A.$B.$C.1"

        # Cambio yml a multi-proyecto
        warp_network_multi

    else
        # Cambia IP a mono-proyecto

        HTTP_HOST_NEW="HTTP_HOST_IP=0.0.0.0"
        HTTP_BINDED_NEW="HTTP_BINDED_PORT=$http_port"
        HTTPS_BINDED_NEW="HTTPS_BINDED_PORT=$https_port"

        NETWORK_SUBNET_NEW="NETWORK_SUBNET=0.0.0.0\/24"
        NETWORK_GATEWAY_NEW="NETWORK_GATEWAY=0.0.0.0"

        # Cambio yml a multi-proyecto
        warp_network_mono

    fi;

    # CHANGE IP AND PORT WEB
    cat $ENVIRONMENTVARIABLESFILE | sed -e "s/$HTTP_HOST_OLD/$HTTP_HOST_NEW/" > "$ENVIRONMENTVARIABLESFILE.warp1"
    mv "$ENVIRONMENTVARIABLESFILE.warp1" $ENVIRONMENTVARIABLESFILE

    cat $ENVIRONMENTVARIABLESFILE | sed -e "s/$HTTP_BINDED_OLD/$HTTP_BINDED_NEW/" > "$ENVIRONMENTVARIABLESFILE.warp2"
    mv "$ENVIRONMENTVARIABLESFILE.warp2" $ENVIRONMENTVARIABLESFILE

    cat $ENVIRONMENTVARIABLESFILE | sed -e "s/$HTTPS_BINDED_OLD/$HTTPS_BINDED_NEW/" > "$ENVIRONMENTVARIABLESFILE.warp3"
    mv "$ENVIRONMENTVARIABLESFILE.warp3" $ENVIRONMENTVARIABLESFILE

    cat $ENVIRONMENTVARIABLESFILE | sed -e "s/$NETWORK_SUBNET_OLD/$NETWORK_SUBNET_NEW/" > "$ENVIRONMENTVARIABLESFILE.warp4"
    mv "$ENVIRONMENTVARIABLESFILE.warp4" $ENVIRONMENTVARIABLESFILE

    cat $ENVIRONMENTVARIABLESFILE | sed -e "s/$NETWORK_GATEWAY_OLD/$NETWORK_GATEWAY_NEW/" > "$ENVIRONMENTVARIABLESFILE.warp5"
    mv "$ENVIRONMENTVARIABLESFILE.warp5" $ENVIRONMENTVARIABLESFILE

    # CHANGE PORT MYSQL
    BINDED_PORT_OLD="DATABASE_BINDED_PORT=$DATABASE_BINDED_PORT"
    BINDED_PORT_NEW="DATABASE_BINDED_PORT=$mysql_binded_port"

    cat $ENVIRONMENTVARIABLESFILE | sed -e "s/$BINDED_PORT_OLD/$BINDED_PORT_NEW/" > "$ENVIRONMENTVARIABLESFILE.warp6"
    mv "$ENVIRONMENTVARIABLESFILE.warp6" $ENVIRONMENTVARIABLESFILE

    . "$WARPFOLDER/setup/init/info.sh"
