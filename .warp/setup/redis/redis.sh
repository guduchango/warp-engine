#!/bin/bash +x

echo ""
warp_message_info "Configurando el Servicio de Redis"

PATH_CONFIG_REDIS='./.warp/docker/config/redis'
MSJ_REDIS_VERSION_HUB=1 # True

respuesta_redis_cache=$( warp_question_ask_default "Queres agregar un servicio para Redis Cache? $(warp_message_info [Y/n]) " "Y" )
if [ "$respuesta_redis_cache" = "Y" ] || [ "$respuesta_redis_cache" = "y" ]
then

    if [ $MSJ_REDIS_VERSION_HUB = 1 ] ; then
        warp_message_info2 "Podes chequear las versiones de Redis disponibles acá: $(warp_message_info '[ https://hub.docker.com/_/redis/ ]')"
        MSJ_REDIS_VERSION_HUB=0 # False
        echo "#Config Redis" >> $ENVIRONMENTVARIABLESFILESAMPLE
    fi
  
    resp_version_cache=$( warp_question_ask_default "Que version de Redis cache queres utilizar? $(warp_message_info [3.2.10-alpine]) " "3.2.10-alpine" )
    warp_message_info2 "version de Redis Cache seleccionada: $resp_version_cache"

    while : ; do
        echo ""
        redis_cache_port=$( warp_question_ask_default "Mapeo del puerto 6379 del contenedor al puerto de tu maquina (host)? $(warp_message_info [6379]) " "6379" )

        #CHECK si port es numero antes de llamar a warp_net_port_in_use
        if ! warp_net_port_in_use $redis_cache_port ; then
            warp_message_info2 "El puerto seleccionado es: $redis_cache_port, el mapeo de puertos es: $(warp_message_bold '127.0.0.1:'$redis_cache_port' ---> container_ip:'$redis_cache_port)"
            break
        else
            warp_message_warn "El puerto $redis_cache_port esta ocupado, elige otro\n"
        fi;
    done

    cache_config_file_cache=$( warp_question_ask_default "Archivo de configuracion de Redis? $(warp_message_info [./.warp/docker/config/redis/redis.conf]) " "./.warp/docker/config/redis/redis.conf" )
    
    cat $PROJECTPATH/.warp/setup/redis/tpl/redis_cache.yml >> $DOCKERCOMPOSEFILE

    echo "REDIS_CACHE_VERSION=$resp_version_cache" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "REDIS_CACHE_CONF=$cache_config_file_cache" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "REDIS_CACHE_BINDED_PORT=$redis_cache_port" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "" >> $ENVIRONMENTVARIABLESFILESAMPLE

    # Control will enter here if $PATH_CONFIG_REDIS doesn't exist.
    if [ ! -d "$PATH_CONFIG_REDIS" ]; then
        cp -R ./.warp/setup/redis/config/redis $PATH_CONFIG_REDIS
    fi
    echo ""
fi; 

respuesta_redis_session=$( warp_question_ask_default "Queres agregar un servicio para Redis Session? $(warp_message_info [Y/n]) " "Y" )
if [ "$respuesta_redis_session" = "Y" ] || [ "$respuesta_redis_session" = "y" ]
then

    if [ $MSJ_REDIS_VERSION_HUB = 1 ] ; then
        warp_message_info2 "Podes chequear las versiones de Redis disponibles acá: $(warp_message_info '[ https://hub.docker.com/_/redis/ ]')"
        MSJ_REDIS_VERSION_HUB=0 # False
        echo "#Config Redis" >> $ENVIRONMENTVARIABLESFILESAMPLE
    fi
  
    resp_version_session=$( warp_question_ask_default "Que version de Redis Session queres utilizar? $(warp_message_info [3.2.10-alpine]) " "3.2.10-alpine" )
    warp_message_info2 "version de Redis Session seleccionada: $resp_version_session"

    while : ; do
        echo ""
        redis_session_port=$( warp_question_ask_default "Mapeo del puerto 6379 del contenedor al puerto de tu maquina (host)? $(warp_message_info [6380]) " "6380" )

        #CHECK si port es numero antes de llamar a warp_net_port_in_use
        if ! warp_net_port_in_use $redis_session_port ; then
            warp_message_info2 "El puerto seleccionado es: $redis_session_port, el mapeo de puertos es: $(warp_message_bold '127.0.0.1:'$redis_session_port' ---> container_ip:'$redis_session_port)"
            break
        else
            warp_message_warn "El puerto $redis_session_port esta ocupado, elige otro\n"
        fi;
    done

    cache_config_file_session=$( warp_question_ask_default "Archivo de configuracion de Redis? $(warp_message_info [./.warp/docker/config/redis/redis.conf]) " "./.warp/docker/config/redis/redis.conf" )
    
    cat $PROJECTPATH/.warp/setup/redis/tpl/redis_session.yml >> $DOCKERCOMPOSEFILE

    echo "REDIS_SESSION_VERSION=$resp_version_session" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "REDIS_SESSION_CONF=$cache_config_file_session" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "REDIS_SESSION_BINDED_PORT=$redis_session_port" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "" >> $ENVIRONMENTVARIABLESFILESAMPLE

    # Control will enter here if $PATH_CONFIG_REDIS doesn't exist.
    if [ ! -d "$PATH_CONFIG_REDIS" ]; then
        cp -R ./.warp/setup/redis/config/redis $PATH_CONFIG_REDIS
    fi
    echo ""
fi; 

respuesta_redis_fpc=$( warp_question_ask_default "Queres agregar un servicio para Redis FPC? $(warp_message_info [Y/n]) " "Y" )
if [ "$respuesta_redis_fpc" = "Y" ] || [ "$respuesta_redis_fpc" = "y" ]
then

    if [ $MSJ_REDIS_VERSION_HUB = 1 ] ; then
        warp_message_info2 "Podes chequear las versiones de Redis disponibles acá: $(warp_message_info '[ https://hub.docker.com/_/redis/ ]')"
        MSJ_REDIS_VERSION_HUB=0 # False
        echo "#Config Redis" >> $ENVIRONMENTVARIABLESFILESAMPLE
    fi

    resp_version_fpc=$( warp_question_ask_default "Que version de Redis FPC queres utilizar? $(warp_message_info [3.2.10-alpine]) " "3.2.10-alpine" )
    warp_message_info2 "version de Redis FPC seleccionada: $resp_version_fpc"

    while : ; do
        echo ""
        redis_fpc_port=$( warp_question_ask_default "Mapeo del puerto 6379 del contenedor al puerto de tu maquina (host)? $(warp_message_info [6381]) " "6381" )

        #CHECK si port es numero antes de llamar a warp_net_port_in_use
        if ! warp_net_port_in_use $redis_fpc_port ; then
            warp_message_info2 "El puerto seleccionado es: $redis_fpc_port, el mapeo de puertos es: $(warp_message_bold '127.0.0.1:'$redis_fpc_port' ---> container_ip:'$redis_fpc_port)"
            break
        else
            warp_message_warn "El puerto $redis_fpc_port esta ocupado, elige otro\n"
        fi;
    done

    cache_config_file_fpc=$( warp_question_ask_default "Archivo de configuracion de Redis? $(warp_message_info [./.warp/docker/config/redis/redis.conf]) " "./.warp/docker/config/redis/redis.conf" )
    
    cat $PROJECTPATH/.warp/setup/redis/tpl/redis_fpc.yml >> $DOCKERCOMPOSEFILE

    echo "REDIS_FPC_VERSION=$resp_version_fpc" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "REDIS_FPC_CONF=$cache_config_file_fpc" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "REDIS_FPC_BINDED_PORT=$redis_fpc_port" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "" >> $ENVIRONMENTVARIABLESFILESAMPLE

    # Control will enter here if $PATH_CONFIG_REDIS doesn't exist.
    if [ ! -d "$PATH_CONFIG_REDIS" ]; then
        cp -R ./.warp/setup/redis/config/redis $PATH_CONFIG_REDIS
    fi
    echo ""
fi; 
