#!/bin/bash

    # IMPORT HELP

    . "$PROJECTPATH/.warp/bin/fix_help.sh"

function fix_add_user()
{
    case "$(uname -s)" in
      Darwin)
        warp_message "* this command is not necessary for macOS $(warp_message_ok [ok])"
      ;;
      Linux)
        warp_message "* Adding host user: $(whoami) to docker and www-data groups $(warp_message_ok [ok])"

        # add user docker to current user
        sudo usermod -aG docker $(whoami)

        # add ID user 33 (www-data inside container) to current user
        sudo usermod -aG 33 $(whoami)

      ;;
    esac

    exit 1;
}

function fix_php()
{

    warp_message "* Applying permissions for php logs .warp/docker/volumes/php-fpm $(warp_message_ok [ok])"

    # add permission php logs

    [ -d $PROJECTPATH/.warp/docker/volumes/php-fpm/ ] && sudo chmod -R 775 $PROJECTPATH/.warp/docker/volumes/php-fpm
    [ -d $PROJECTPATH/.warp/docker/volumes/php-fpm/ ] && sudo chgrp -R 33 $PROJECTPATH/.warp/docker/volumes/php-fpm

    exit 1;
}

function fix_elasticsearch()
{
    warp_message "* Applying permissions to subdirectories .warp/docker/volumes/elasticsearch $(warp_message_ok [ok])"

    mkdir -p   $PROJECTPATH/.warp/docker/volumes/elasticsearch
    sudo chmod -R a+rwx $PROJECTPATH/.warp/docker/volumes/elasticsearch

    exit 1;
}

function fix_grunt()
{

    warp_message "* Applying permissions $(warp_message_ok [ok])"
    sudo find $PROJECTPATH/pub -type d -exec chmod ug+rwx {} \; # Make folders traversable and read/write

    warp_message "* Make files read/write $(warp_message_ok [ok])"
    sudo find $PROJECTPATH/pub -type f -exec chmod a+rw {} \;  # Make files read/write

    warp_message "* Deleting var/cache $(warp_message_ok [ok])"
    [ -d $PROJECTPATH/var/cache ] && sudo rm -rf $PROJECTPATH/var/cache

    exit 1;
}

function fix_mysql()
{
    warp_message "* Applying user (mysql) and group (mysql) to MySQL container $(warp_message_ok [ok])"

    # add permission MySQL 999 (mysql inside the container)
    [ -d $PROJECTPATH/.warp/docker/volumes/mysql/ ] && sudo chown -R 999:999 $PROJECTPATH/.warp/docker/volumes/mysql/

    exit 1;
}

function fix_default()
{
    # fix user and groups to current project
    warp_message "* Applying user: $(whoami) and group: www-data to files and folders $(warp_message_ok [ok])"
    sudo chown -R $(whoami):33 $(ls)

    warp_message "* Make folders traversable and read/write $(warp_message_ok [ok])"
    sudo find $(ls) -type d -exec chmod ug+rwx {} \; # Make folders traversable and read/write

    warp_message "* Make files read/write $(warp_message_ok [ok])"
    sudo find $(ls) -type f -exec chmod a+rw {} \;  # Make files read/write

    warp_message "* Applying permissions to subdirectories .warp/docker/volumes $(warp_message_ok [ok])"

    # add permission elasticsearch inside the container    
    [ -d $PROJECTPATH/.warp/docker/volumes/elasticsearch/ ] && sudo chmod -R a+rwx $PROJECTPATH/.warp/docker/volumes/elasticsearch/
    [ -d $PROJECTPATH/.warp/docker/volumes/php-fpm/ ] && sudo chmod -R 775 $PROJECTPATH/.warp/docker/volumes/php-fpm

    warp_message "* Applying permissions to binaries $(warp_message_ok [ok])"
    # restart correct permissions to warp and binaries
    [ -f $PROJECTPATH/warp ] && sudo chmod a+x $PROJECTPATH/warp
    [ -d $PROJECTPATH/bin ] && sudo chmod a+x $PROJECTPATH/bin/*

    warp_message "* Success $(warp_message_ok [ok])"
    exit 1;
}

function fix_permissions() 
{

    if [ "$1" = "-h" ] || [ "$1" = "--help" ]
    then
        fix_help_usage 
        exit 1
    fi;

    if [ $(warp_check_is_running) = false ]; then
        warp_message_error "The containers are not running"
        warp_message_error "please, first run warp start"

        exit 1;
    fi

    case "$1" in
      "--addUser")
            fix_add_user 
            exit 1
      ;;
      "--php")
            fix_php
            exit 1
      ;;
      "--elasticsearch")
            fix_elasticsearch
            exit 1
      ;;
      "--mysql")
            fix_mysql
            exit 1
      ;;
      "--all")
            fix_php
            fix_mysql
            fix_elasticsearch
            fix_grunt
            fix_add_user
            exit 1
      ;;
      *)
            fix_default
      ;;      
    esac
}

function fix_main()
{
    case "$1" in
        fix)
            shift 1
            fix_permissions $*
        ;;

        -h | --help)
            fix_help_usage
        ;;

        *)            
            fix_help_usage
        ;;
    esac
}