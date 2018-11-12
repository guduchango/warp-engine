#!/bin/bash +x

echo ""
warp_message_info "Configuring PHP Service"

while : ; do
    respuesta_php=$( warp_question_ask_default "Do you want to add a php service? $(warp_message_info [Y/n]) " "Y" )

    if [ "$respuesta_php" = "Y" ] || [ "$respuesta_php" = "y" ] || [ "$respuesta_php" = "N" ] || [ "$respuesta_php" = "n" ] ; then
        break
    else
        warp_message_warn "wrong answer, you must select between two options: $(warp_message_info [Y/n]) "
    fi
done

if [ "$respuesta_php" = "Y" ] || [ "$respuesta_php" = "y" ]
then
    
    while : ; do
        php_version=$( warp_question_ask_default "What is the php version of the project? $(warp_message_info [7.0-fpm]) " "7.0-fpm" )
    
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
            warp_message_info2 "Selected: $php_version, the available versions are 7.0-fpm, 7.1-fpm, 7.1.17-fpm"
        ;;
        esac        
    done
    warp_message_info2 "PHP version selected: $php_version"
    
    cat $PROJECTPATH/.warp/setup/php/tpl/php.yml >> $DOCKERCOMPOSEFILESAMPLE

    echo ""  >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "# Config PHP" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "PHP_VERSION=$php_version" >> $ENVIRONMENTVARIABLESFILESAMPLE

    echo ""  >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "# Config xdebug by Console"  >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "XDEBUG_CONFIG=remote_host=172.17.0.1" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "PHP_IDE_CONFIG=serverName=docker" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo ""  >> $ENVIRONMENTVARIABLESFILESAMPLE

    mkdir -p $PROJECTPATH/.warp/docker/volumes/php-fpm/logs 2> /dev/null
    # Create logs file
    [ ! -f $PROJECTPATH/.warp/docker/volumes/php-fpm/logs/access.log ] && touch $PROJECTPATH/.warp/docker/volumes/php-fpm/logs/access.log  2> /dev/null
    [ ! -f $PROJECTPATH/.warp/docker/volumes/php-fpm/logs/fpm-error.log ] && touch $PROJECTPATH/.warp/docker/volumes/php-fpm/logs/fpm-error.log 2> /dev/null
    [ ! -f $PROJECTPATH/.warp/docker/volumes/php-fpm/logs/fpm-php.www.log ] && touch $PROJECTPATH/.warp/docker/volumes/php-fpm/logs/fpm-php.www.log 2> /dev/null
    # chmod -R 775 $PROJECTPATH/.warp/docker/volumes/php-fpm 2> /dev/null
 
    cp -R $PROJECTPATH/.warp/setup/php/config/php $PROJECTPATH/.warp/docker/config/php
fi; 