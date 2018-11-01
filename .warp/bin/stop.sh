#!/bin/bash

    # IMPORT HELP

    . "$PROJECTPATH/.warp/bin/stop_help.sh"

#######################################
# Stop the server
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None

##-c ####################-c #################
function stop() {

  if [ "$1" = "-h" ] || [ "$1" = "--help" ] ; then
        
      stop_help_usage
  else
    if [ $(warp_check_is_running) = true ]; then
      # stop all docker containers
      docker-compose -f $DOCKERCOMPOSEFILE down
    fi
  fi;

}

function stop_main()
{
    case "$1" in
        stop)
          shift 1
          stop $*
        ;;

        *)
          stop_help_usage
        ;;
    esac
}
