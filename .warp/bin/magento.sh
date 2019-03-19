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
        warp_message_error "The containers are not running"
        warp_message_error "please, first run warp start"

        exit 1;
    fi

    FRAMEWORK=$(warp_env_read_var FRAMEWORK)
    if [ "$FRAMEWORK" = "m1" ]
    then
        MAGENTOBIN='./n98-magerun'
    else
        MAGENTOBIN='bin/magento'
    fi

    if [ "$1" = "--root" ]
    then
        shift 1
        docker-compose -f $DOCKERCOMPOSEFILE exec -uroot php bash -c "$MAGENTOBIN $*"
    elif [ "$1" = "-T" ] ; then
        shift 1
        docker-compose -f $DOCKERCOMPOSEFILE exec -T php bash -c "$MAGENTOBIN $*"
    else

        docker-compose -f $DOCKERCOMPOSEFILE exec php bash -c "$MAGENTOBIN $*"
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