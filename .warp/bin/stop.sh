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
      exit 1;
  else
    if [ $(warp_check_is_running) = true ]; then

      if [ "$1" = "--hard" ] ; then
        DOCKERACTION=down
      else
        DOCKERACTION=stop
      fi;

      case "$(uname -s)" in
        Darwin)
          docker stop $(basename $(pwd))-volume-sync
          docker-sync stop

          # stop docker containers in macOS
          docker-compose -f $DOCKERCOMPOSEFILE $DOCKERACTION
        ;;
        Linux)
          # stop docker containers in linux
          docker-compose -f $DOCKERCOMPOSEFILE $DOCKERACTION
        ;;
      esac
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
