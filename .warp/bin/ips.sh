#!/bin/bash

    # IMPORT HELP

    . "$PROJECTPATH/.warp/bin/ips_help.sh"

#######################################
# Start the server and all of its
# components
# Globals:
#   None
# Arguments:
#   services
# Returns:
#   ips and names of each services
#######################################
function ips() {

  if [ "$1" = "-h" ] || [ "$1" = "--help" ] ; then
        
      ips_help_usage
      exit 1;
  else

    if [ $(warp_check_is_running) = false ]; then
        warp_message_error "The containers are not running"
        warp_message_error "please, first run warp start"

        exit 1;
    fi

    if [ "$1" ]; then
      docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}   {{.Name}}'   $(docker-compose -f  $DOCKERCOMPOSEFILE ps -q $*) | sed 's/ \// /'
    else
      docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}   {{.Name}}'   $(docker ps --format "{{.Names}}") | sed 's/ \// /'
    fi;

  fi;
}

function ips_main()
{
    case "$1" in
        ips)
          shift 1
          ips $*
        ;;

        *)
          ips_help_usage
        ;;
    esac
}
