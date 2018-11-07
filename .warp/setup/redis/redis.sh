#!/bin/bash +x

warp_message ""
warp_message_info "Configurando el Servicio de Redis"

PATH_CONFIG_REDIS='./.warp/docker/config/redis'
MSJ_REDIS_VERSION_HUB=1 # True

while : ; do
    respuesta_redis_cache=$( warp_question_ask_default "Queres agregar un servicio para Redis Cache? $(warp_message_info [Y/n]) " "Y" )

    if [ "$respuesta_redis_cache" = "Y" ] || [ "$respuesta_redis_cache" = "y" ] || [ "$respuesta_redis_cache" = "N" ] || [ "$respuesta_redis_cache" = "n" ] ; then
        break
    else
        warp_message_warn "Respuesta Incorrecta, debe seleccionar entre dos opciones: $(warp_message_info [Y/n]) "
    fi
done

if [ "$respuesta_redis_cache" = "Y" ] || [ "$respuesta_redis_cache" = "y" ]
then

    if [ $MSJ_REDIS_VERSION_HUB = 1 ] ; then
        warp_message_info2 "Podes chequear las versiones de Redis disponibles acá: $(warp_message_info '[ https://hub.docker.com/_/redis/ ]')"
        MSJ_REDIS_VERSION_HUB=0 # False
        echo "#Config Redis" >> $ENVIRONMENTVARIABLESFILESAMPLE
    fi
  
    resp_version_cache=$( warp_question_ask_default "Que version de Redis cache queres utilizar? $(warp_message_info [3.2.10-alpine]) " "3.2.10-alpine" )
    warp_message_info2 "version de Redis Cache seleccionada: $resp_version_cache, en el puerto interno 6379 $(warp_message_bold 'redis-cache:6379')"

    cache_config_file_cache=$( warp_question_ask_default "Archivo de configuracion de Redis? $(warp_message_info [./.warp/docker/config/redis/redis.conf]) " "./.warp/docker/config/redis/redis.conf" )
    warp_message_info2 "Archivo de configuracion seleccionado: $cache_config_file_cache"
    
    cat $PROJECTPATH/.warp/setup/redis/tpl/redis_cache.yml >> $DOCKERCOMPOSEFILE

    echo "REDIS_CACHE_VERSION=$resp_version_cache" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "REDIS_CACHE_CONF=$cache_config_file_cache" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "" >> $ENVIRONMENTVARIABLESFILESAMPLE

    # Control will enter here if $PATH_CONFIG_REDIS doesn't exist.
    if [ ! -d "$PATH_CONFIG_REDIS" ]; then
        cp -R ./.warp/setup/redis/config/redis $PATH_CONFIG_REDIS
    fi
    warp_message ""
fi; 

while : ; do
    respuesta_redis_session=$( warp_question_ask_default "Queres agregar un servicio para Redis Session? $(warp_message_info [Y/n]) " "Y" )

    if [ "$respuesta_redis_session" = "Y" ] || [ "$respuesta_redis_session" = "y" ] || [ "$respuesta_redis_session" = "N" ] || [ "$respuesta_redis_session" = "n" ] ; then
        break
    else
        warp_message_warn "Respuesta Incorrecta, debe seleccionar entre dos opciones: $(warp_message_info [Y/n]) "
    fi
done

if [ "$respuesta_redis_session" = "Y" ] || [ "$respuesta_redis_session" = "y" ]
then

    if [ $MSJ_REDIS_VERSION_HUB = 1 ] ; then
        warp_message_info2 "Podes chequear las versiones de Redis disponibles acá: $(warp_message_info '[ https://hub.docker.com/_/redis/ ]')"
        MSJ_REDIS_VERSION_HUB=0 # False
        echo "#Config Redis" >> $ENVIRONMENTVARIABLESFILESAMPLE
    fi
  
    resp_version_session=$( warp_question_ask_default "Que version de Redis Session queres utilizar? $(warp_message_info [3.2.10-alpine]) " "3.2.10-alpine" )
    warp_message_info2 "version de Redis Session seleccionada: $resp_version_session, en el puerto interno 6379 $(warp_message_bold 'redis-session:6379')"

    cache_config_file_session=$( warp_question_ask_default "Archivo de configuracion de Redis? $(warp_message_info [./.warp/docker/config/redis/redis.conf]) " "./.warp/docker/config/redis/redis.conf" )
    warp_message_info2 "Archivo de configuracion seleccionado: $cache_config_file_session"

    cat $PROJECTPATH/.warp/setup/redis/tpl/redis_session.yml >> $DOCKERCOMPOSEFILE

    echo "REDIS_SESSION_VERSION=$resp_version_session" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "REDIS_SESSION_CONF=$cache_config_file_session" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "" >> $ENVIRONMENTVARIABLESFILESAMPLE

    # Control will enter here if $PATH_CONFIG_REDIS doesn't exist.
    if [ ! -d "$PATH_CONFIG_REDIS" ]; then
        cp -R ./.warp/setup/redis/config/redis $PATH_CONFIG_REDIS
    fi
    warp_message ""
fi; 

while : ; do
    respuesta_redis_fpc=$( warp_question_ask_default "Queres agregar un servicio para Redis FPC? $(warp_message_info [Y/n]) " "Y" )

    if [ "$respuesta_redis_fpc" = "Y" ] || [ "$respuesta_redis_fpc" = "y" ] || [ "$respuesta_redis_fpc" = "N" ] || [ "$respuesta_redis_fpc" = "n" ] ; then
        break
    else
        warp_message_warn "Respuesta Incorrecta, debe seleccionar entre dos opciones: $(warp_message_info [Y/n]) "
    fi
done

if [ "$respuesta_redis_fpc" = "Y" ] || [ "$respuesta_redis_fpc" = "y" ]
then

    if [ $MSJ_REDIS_VERSION_HUB = 1 ] ; then
        warp_message_info2 "Podes chequear las versiones de Redis disponibles acá: $(warp_message_info '[ https://hub.docker.com/_/redis/ ]')"
        MSJ_REDIS_VERSION_HUB=0 # False
        echo "#Config Redis" >> $ENVIRONMENTVARIABLESFILESAMPLE
    fi

    resp_version_fpc=$( warp_question_ask_default "Que version de Redis FPC queres utilizar? $(warp_message_info [3.2.10-alpine]) " "3.2.10-alpine" )
    warp_message_info2 "version de Redis FPC seleccionada: $resp_version_fpc, en el puerto interno 6379 $(warp_message_bold 'redis-fpc:6379')"

    cache_config_file_fpc=$( warp_question_ask_default "Archivo de configuracion de Redis? $(warp_message_info [./.warp/docker/config/redis/redis.conf]) " "./.warp/docker/config/redis/redis.conf" )
    warp_message_info2 "Archivo de configuracion seleccionado: $cache_config_file_fpc"

    cat $PROJECTPATH/.warp/setup/redis/tpl/redis_fpc.yml >> $DOCKERCOMPOSEFILE

    echo "REDIS_FPC_VERSION=$resp_version_fpc" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "REDIS_FPC_CONF=$cache_config_file_fpc" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "" >> $ENVIRONMENTVARIABLESFILESAMPLE

    # Control will enter here if $PATH_CONFIG_REDIS doesn't exist.
    if [ ! -d "$PATH_CONFIG_REDIS" ]; then
        cp -R ./.warp/setup/redis/config/redis $PATH_CONFIG_REDIS
    fi
    warp_message ""
fi; 
