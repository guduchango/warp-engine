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
warp_message_info "Configuring Web Server - Nginx"
warp_message ""

    warp_check_os_mac

    useproxy=1 #False

    case "$(uname -s)" in
        Linux)
            resp_reverse_proxy=$( warp_question_ask_default "Do you want to configure a static ip to support more than one project in parallel? $(warp_message_info [y/N]) " "N" )
            if [ "$resp_reverse_proxy" = "Y" ] || [ "$resp_reverse_proxy" = "y" ]
            then
                # autodetect docker in linux
                useproxy=0 #True
            fi;
        ;;
    esac

    if [ $useproxy = 1 ]; then
        while : ; do
            http_port=$( warp_question_ask_default "Mapping container port 80 to your machine port (host): $(warp_message_info [80]) " "80" )

            #CHECK si port es numero antes de llamar a warp_net_port_in_use
            if ! warp_net_port_in_use $http_port ; then
                warp_message_info2 "The selected port is: $http_port, the configuration for the file /etc/hosts is: $(warp_message_bold '127.0.0.1 '$VIRTUAL_HOST)"
                break
            else
                warp_message_warn "the port $http_port is busy, choose another one\n"
            fi;
        done

        while : ; do
            https_port=$( warp_question_ask_default "Mapping container port 443 to your machine port (host): $(warp_message_info [443]) " "443" )

            if ! warp_net_port_in_use $https_port ; then
                warp_message_info2 "The selected port is: $https_port, the configuration for the file /etc/hosts is: $(warp_message_bold '127.0.0.1 '$VIRTUAL_HOST)"
                break
            else
                warp_message_warn "the port $https_port is busy, choose another one\n"
            fi;
        done
    else 
        while : ; do
            http_container_ip=$( warp_question_ask_default "Enter the IP number to assign it to the container $(warp_message_info '[range 172.50.0.'$MIN_RANGE_IP' - 172.50.0.255]') " "172.50.0.$MIN_RANGE_IP" )

            if warp_check_range_ip $http_container_ip ; then
                RANGE=$(echo $http_container_ip | cut -f1 -f2 -f3 -d .)
                warp_message_warn "You should select an IP range between: $RANGE.$MIN_RANGE_IP and $RANGE.255\n"
            else 
                if ! warp_net_ip_in_use $http_container_ip ; then
                    warp_message_info2 "The selected IP is: $http_container_ip, the configuration for the file /etc/hosts is: $(warp_message_bold $http_container_ip' '$VIRTUAL_HOST)"
                    break
                else
                    warp_message_warn "the IP $http_container_ip is being used in another project, choose another one\n"
                fi;
            fi;
        done
    fi; 

    if [ ! -z "$DATABASE_BINDED_PORT" ]
    then
        warp_message ""
        warp_message_info "Configuring the MySQL Service"
        warp_message ""

        while : ; do
            mysql_binded_port=$( warp_question_ask_default "Mapping container port 3306 to your machine port (host): $(warp_message_info [3306]) " "3306" )

            #CHECK si port es numero antes de llamar a warp_net_port_in_use
            if ! warp_net_port_in_use $mysql_binded_port ; then
                warp_message_info2 "the selected port is: $mysql_binded_port, the port mapping is: $(warp_message_bold '127.0.0.1:'$mysql_binded_port' ---> container_host:3306')"
                break
            else
                warp_message_warn "The port $mysql_binded_port is busy, choose another one\n"
            fi;
        done
    fi

    if [ ! -z "$RABBIT_VERSION" ]
    then
    
        warp_message ""
        warp_message_info "Configuring the Rabbit Service"
        warp_message ""

        while : ; do
            rabbit_binded_port=$( warp_question_ask_default "Mapping container port 15672 to your machine port (host): $(warp_message_info [8080]) " "8080" )

            if ! warp_net_port_in_use $rabbit_binded_port ; then
                warp_message_info2 "the selected port is: $rabbit_binded_port, the port mapping is: $(warp_message_bold '127.0.0.1:'$rabbit_binded_port' ---> container_host:15672')"
                break
            else
                warp_message_warn "The port $rabbit_binded_port is busy, choose another one\n"
            fi;
        done
    fi

    if [ ! -z "$MAILHOG_BINDED_PORT" ]
    then
    
        warp_message ""
        warp_message_info "Configuring Mailhog SMTP server"
        warp_message ""

        while : ; do
            mailhog_binded_port=$( warp_question_ask_default "Plase select the port of your machine (host) to Web interface to view the messages: $(warp_message_info [8025]) " "8025" )

            if ! warp_net_port_in_use $mailhog_binded_port ; then
                warp_message_info2 "the selected port is: $mailhog_binded_port, Web interface to view the messages: $(warp_message_bold 'http://127.0.0.1:'$mailhog_binded_port)"
                break
            else
                warp_message_warn "The port $mailhog_binded_port is busy, choose another one\n"
            fi;
        done
    fi

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


    if [ ! -z "$DATABASE_BINDED_PORT" ]
    then
        # CHANGE PORT MYSQL
        BINDED_PORT_OLD="DATABASE_BINDED_PORT=$DATABASE_BINDED_PORT"
        BINDED_PORT_NEW="DATABASE_BINDED_PORT=$mysql_binded_port"

        cat $ENVIRONMENTVARIABLESFILE | sed -e "s/$BINDED_PORT_OLD/$BINDED_PORT_NEW/" > "$ENVIRONMENTVARIABLESFILE.warp6"
        mv "$ENVIRONMENTVARIABLESFILE.warp6" $ENVIRONMENTVARIABLESFILE
    fi


    if [ ! -z "$RABBIT_VERSION" ]
    then
        # CHANGE PORT RABBIT
        BINDED_PORT_OLD="RABBIT_BINDED_PORT=$RABBIT_BINDED_PORT"
        BINDED_PORT_NEW="RABBIT_BINDED_PORT=$rabbit_binded_port"

        cat $ENVIRONMENTVARIABLESFILE | sed -e "s/$BINDED_PORT_OLD/$BINDED_PORT_NEW/" > "$ENVIRONMENTVARIABLESFILE.warp7"
        mv "$ENVIRONMENTVARIABLESFILE.warp7" $ENVIRONMENTVARIABLESFILE
    fi

    if [ ! -z "$MAILHOG_BINDED_PORT" ]
    then
        # CHANGE PORT MAILHOG
        BINDED_PORT_OLD="MAILHOG_BINDED_PORT=$MAILHOG_BINDED_PORT"
        BINDED_PORT_NEW="MAILHOG_BINDED_PORT=$mailhog_binded_port"

        cat $ENVIRONMENTVARIABLESFILE | sed -e "s/$BINDED_PORT_OLD/$BINDED_PORT_NEW/" > "$ENVIRONMENTVARIABLESFILE.warp8"
        mv "$ENVIRONMENTVARIABLESFILE.warp8" $ENVIRONMENTVARIABLESFILE
    fi

    . "$WARPFOLDER/setup/init/info.sh"
