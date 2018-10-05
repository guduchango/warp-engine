#!/bin/bash


function info()
{
    if ! warp_check_env_file ; then
        warp_message_error "No se encuentra el archivo .env"
        exit
    fi; 

    DATABASE_NAME=$(warp_env_read_var DATABASE_NAME)
    DATABASE_USER=$(warp_env_read_var DATABASE_USER)
    DATABASE_PASSWORD=$(warp_env_read_var DATABASE_PASSWORD)
    DATABASE_ROOT_PASSWORD=$(warp_env_read_var DATABASE_ROOT_PASSWORD)
    DATABASE_BINDED_PORT=$(warp_env_read_var DATABASE_BINDED_PORT)

    warp_message_info "* MySQL Info"
    warp_message_info2 "Usuario root habilitado por default"
    warp_message "Nombre DB: $(warp_message_info $DATABASE_NAME)"
    warp_message "Usuario DB: $(warp_message_info $DATABASE_USER)"
    warp_message "Clave DB: $(warp_message_info $DATABASE_PASSWORD)"
    warp_message "Clave root: $(warp_message_info $DATABASE_ROOT_PASSWORD)"
    warp_message "Puerto mapeado a tu maquina: $(warp_message_info $DATABASE_BINDED_PORT)"

}


function mysql_main()
{
    case "$1" in
        dump)
        echo "MYSQL DUMP"
        ;;

        info)
        info
        ;;

        connect)
            echo "MYSQL CONN"
        ;;

        *)
            . "$PROJECTPATH/.warp/bin/mysql_help.sh"
        ;;
    esac
}

