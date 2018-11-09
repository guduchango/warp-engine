#!/bin/bash

    # IMPORT HELP

    . "$PROJECTPATH/.warp/bin/magento_help.sh"

function magento_command() 
{

    if [ "$1" = "-h" ] || [ "$1" = "--help" ]
    then
        magento_help_usage 
        exit 1
    fi;

    if [ $(warp_check_is_running) = false ]; then
        warp_message_error "Los contenedores no estan corriendo"
        warp_message_error "este comando necesita previamente que ejecutes warp start"

        exit 1;
    fi

    if [ "$1" = "--root" ]
    then
        shift 1
        docker-compose -f $DOCKERCOMPOSEFILE exec -uroot php bash -c "bin/magento $*"
    elif [ "$1" = "-T" ] ; then
        shift 1
        docker-compose -f $DOCKERCOMPOSEFILE exec -T php bash -c "bin/magento $*"
    else

        docker-compose -f $DOCKERCOMPOSEFILE exec php bash -c "bin/magento $*"
    fi
}

function magento_main()
{
    case "$1" in
        magento)
            shift 1
            magento_command $*
        ;;

        -h | --help)
            magento_help_usage
        ;;

        *)            
            magento_help_usage
        ;;
    esac
}