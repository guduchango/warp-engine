#!/bin/bash

    # IMPORT HELP

    . "$PROJECTPATH/.warp/bin/init_help.sh"

#######################################
# Start the server and all of its
# components
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
#######################################
function init_command() {
    echo ""
    warp_banner
    echo ""

    if [ -f $DOCKERCOMPOSEFILE ] || [ -f $ENVIRONMENTVARIABLESFILESAMPLE ]; then

        if [ ! -f $ENVIRONMENTVARIABLESFILE ]; then
            # INIT WIZARD MODE DEVELOPER
            . "$WARPFOLDER/setup/init/developer.sh"
        else
            INFRA_FILES_ERROR="FALSE"
            if [ -f $DOCKERCOMPOSEFILE ]; then
                echo "* Comprobando archivo $(basename $DOCKERCOMPOSEFILE) $(warp_message_ok [ok])"
            else
                INFRA_FILES_ERROR="TRUE"
                echo "* Comprobando archivo $(basename $DOCKERCOMPOSEFILE) $(warp_message_error [error])"
            fi; 
            
            if [ -f $ENVIRONMENTVARIABLESFILE ]; then
                echo "* Comprobando archivo $(basename $ENVIRONMENTVARIABLESFILE) $(warp_message_ok [ok])"
            else
                INFRA_FILES_ERROR="TRUE"
                echo "* Comprobando archivo $(basename $ENVIRONMENTVARIABLESFILE) $(warp_message_error [error])"
            fi;

            if [ $INFRA_FILES_ERROR = "TRUE" ]; then
                warp_message_warn "-- Ambos archivos ($(basename $DOCKERCOMPOSEFILE) y $(basename $ENVIRONMENTVARIABLESFILE)) deben existir para poder inicializar los contenedores. $(warp_message_error [error])"
                # warp_message_warn "-- Si queres inicializar un proyecto desde cero, elimina los archivos $(basename $DOCKERCOMPOSEFILE) y $(basename $ENVIRONMENTVARIABLESFILE). Luego volve a ejecutar el comando init "
                exit
            fi
        fi
    else
        # INIT WIZARD MODE TL
        warp_message_info "* Comenzando la instalacion inicial\n"
        . "$WARPFOLDER/setup/init/service.sh"
        . "$WARPFOLDER/setup/webserver/webserver.sh"
        . "$WARPFOLDER/setup/php/php.sh"
        . "$WARPFOLDER/setup/init/volumes.sh"
        . "$WARPFOLDER/setup/mysql/database.sh"
        . "$WARPFOLDER/setup/elasticsearch/elasticsearch.sh"
        . "$WARPFOLDER/setup/redis/redis.sh"
        . "$WARPFOLDER/setup/networks/networks.sh"
        . "$WARPFOLDER/setup/init/info.sh"
    fi;
}

function init_main()
{
    case "$1" in
        init)
          init_command $*
        ;;

        *)
          init_help_usage
        ;;
    esac
}
