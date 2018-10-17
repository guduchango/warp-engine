#!/bin/bash +x

warp_message_info "Configurando Servicio de PHP"

respuesta_php=$( warp_question_ask_default "Queres agregar un servicio de php? $(warp_message_info [Y/n]) " "Y" )
if [ "$respuesta_php" = "Y" ] || [ "$respuesta_php" = "y" ]
then
    
    while : ; do
        php_version=$( warp_question_ask_default "Cual es la version de php del proyecto? $(warp_message_info [7.0-fpm]) " "7.0-fpm" )
    
        case $php_version in
        '7.0-fpm')
            break
        ;;
        '7.1-fpm')
            break
        ;;
        '7.1.17-fpm')
            break
        ;;
        *)
            warp_message_info2 "Seleccionaste: $php_version, las versiones disponibles son 7.0-fpm, 7.1-fpm, 7.1.17-fpm"
        ;;
        esac        
    done
    warp_message_info2 "Version de PHP seleccionada: $php_version"
    
    cat $PROJECTPATH/.warp/setup/php/tpl/php.yml >> $PROJECTPATH/docker-compose.yml

    echo ""  >> $PROJECTPATH/.env
    echo "# Config PHP" >> $PROJECTPATH/.env
    echo "PHP_VERSION=$php_version" >> $PROJECTPATH/.env

    echo ""  >> $PROJECTPATH/.env
    echo "# Config xdebug by Console"  >> $PROJECTPATH/.env
    echo "XDEBUG_CONFIG=remote_host=172.17.0.1" >> $PROJECTPATH/.env
    echo "PHP_IDE_CONFIG=serverName=docker" >> $PROJECTPATH/.env

    mkdir -p ./.warp/docker/volumes/php-fpm/logs
    # Create logs file
    touch ./.warp/docker/volumes/php-fpm/logs/access.log
    touch ./.warp/docker/volumes/php-fpm/logs/fpm-error.log
    touch ./.warp/docker/volumes/php-fpm/logs/fpm-php.www.log
    chmod -R 777 ./.warp/docker/volumes/php-fpm
 
    cp -R ./.warp/setup/php/config/php ./.warp/docker/config/php
fi; 