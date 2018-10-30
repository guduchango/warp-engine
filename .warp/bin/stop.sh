#!/bin/bash

#######################################
# Stop the server
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None

##-c ####################-c #################
stop() {

  if [ $(isRunning) = true ]; then
    # stop all docker containers
    docker-compose -f $DOCKERCOMPOSEFILE down
  fi

}

#######################################
# Check if the docker-components are running
# Globals:
#   DOCKERCOMPOSEFILE
# Arguments:
#   None
# Returns:
#   true|false
#######################################
isRunning() {
  dockerStatusOutput=$(docker-compose -f $DOCKERCOMPOSEFILE ps -q | xargs docker inspect --format='{{ .State.Status }}' | sed 's:^/::g' | grep -i running)
  outputSize=${#dockerStatusOutput}
  if [ "$outputSize" -gt 0 ]; then
    echo true
  else
    echo false
  fi
}

function stop_main()
{
    case "$1" in
        stop)
          stop
        ;;

        *)
          . "$PROJECTPATH/.warp/bin/stop_help.sh"
        ;;
    esac
}
