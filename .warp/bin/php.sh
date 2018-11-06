#!/bin/bash

    # IMPORT HELP

    . "$PROJECTPATH/.warp/bin/php_help.sh"

function php_connect_ssh() 
{

    if [ "$1" = "-h" ] || [ "$1" = "--help" ]
    then
        php_ssh_help 
        exit 1
    fi;

    if [ $(warp_check_is_running) = false ]; then
        warp_message_error "Los contenedores no estan corriendo"
        warp_message_error "este comando necesita previamente que ejecutes warp start"

        exit 1;
    fi

    if [ "$1" = "--root" ]
    then
        docker-compose -f $DOCKERCOMPOSEFILE exec -uroot php bash
    else
        docker-compose -f $DOCKERCOMPOSEFILE exec php bash
    fi;    
}

function php_main()
{
    case "$1" in
        ssh)
            shift 1
            php_connect_ssh $*
        ;;

        -h | --help)
            php_help_usage
        ;;

        *)            
            php_help_usage
        ;;
    esac
}