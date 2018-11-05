#!/bin/bash

    # IMPORT HELP

    . "$PROJECTPATH/.warp/bin/redis_help.sh"

function redis_cli() 
{

    if [ "$1" = "-h" ] || [ "$1" = "--help" ]
    then
        redis_cli_help_usage 
        exit 1
    fi;

    if [ $(warp_check_is_running) = false ]; then
        warp_message_error "Los contenedores no estan corriendo"
        warp_message_error "este comando necesita previamente que ejecutes warp start"

        exit 1;
    fi

    case "$1" in 
        "fpc")
            docker-compose -f $DOCKERCOMPOSEFILE exec -uroot redis-fpc redis-cli
            ;;

        "session")
            docker-compose -f $DOCKERCOMPOSEFILE exec -uroot redis-session redis-cli
            ;;

        "cache")
            docker-compose -f $DOCKERCOMPOSEFILE exec -uroot redis-cache redis-cli
            ;;

        *)            
            warp_message_error "Debe ingresar una opcion valida"
            warp_message_error "fpc, session, cache"
            warp_message_error "para más ayuda ingrese en warp redis cli --help"
        ;;
    esac

}

function redis_monitor() 
{

    if [ "$1" = "-h" ] || [ "$1" = "--help" ]
    then
        redis_monitor_help_usage 
        exit 1
    fi;

    if [ $(warp_check_is_running) = false ]; then
        warp_message_error "Los contenedores no estan corriendo"
        warp_message_error "este comando necesita previamente que ejecutes warp start"

        exit 1;
    fi

    case "$1" in 
        "fpc")
            docker-compose -f $DOCKERCOMPOSEFILE exec -uroot redis-fpc redis-cli -c "monitor"
            ;;

        "session")
            docker-compose -f $DOCKERCOMPOSEFILE exec -uroot redis-session redis-cli -c "monitor"
            ;;

        "cache")
            docker-compose -f $DOCKERCOMPOSEFILE exec -uroot redis-cache redis-cli -c "monitor"
            ;;

        *)            
            warp_message_error "Debe ingresar una opcion valida"
            warp_message_error "fpc, session, cache"
            warp_message_error "para más ayuda ingrese en warp redis monitor --help"
        ;;
    esac

}

function redis_main()
{
    case "$1" in
        cli)
            shift 1
            redis_cli $*
        ;;

        monitor)
            shift 1
            redis_monitor $*
        ;;

        -h | --help)
            redis_help_usage
        ;;

        *)            
            redis_help_usage
        ;;
    esac
}