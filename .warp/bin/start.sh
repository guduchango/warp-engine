#!/bin/bash

    # IMPORT HELP

    . "$PROJECTPATH/.warp/bin/start_help.sh"

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
function start() {

  if [ $(warp_check_is_running) = true ]; then
    warp_message_warn "Los contenedores ya estan corriendo..";
    warp_message_warn "Para detenerlos ejecute: warp stop";
    exit 1;
  fi

  if [ "$1" = "-h" ] || [ "$1" = "--help" ] ; then
        
      start_help_usage
  else

    # start docker containers
    docker-compose -f $DOCKERCOMPOSEFILE up -d
  fi;
}

function start_main()
{
    case "$1" in
        start)
          shift 1
          start $*
        ;;

        *)
          start_help_usage
        ;;
    esac
}
