#!/bin/bash

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
start() {

  if [ $(isRunning) = true ]; then
    echo >&2 "The component are already running";
    exit 1;
  fi

  # start docker containers
  docker-compose -f $DOCKERCOMPOSEFILE up -d
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
  #dockerStatusOutput=$(docker-compose -f $DOCKERCOMPOSEFILE ps -q)
  dockerStatusOutput=$(docker-compose -f $DOCKERCOMPOSEFILE ps -q | xargs docker inspect --format='{{ .State.Status }}' | sed 's:^/::g' | grep -i running)
  outputSize=${#dockerStatusOutput}
  if [ "$outputSize" -gt 0 ]; then
    echo true
  else
    echo false
  fi
}

function start_main()
{
    case "$1" in
        start)
          start
        ;;

        *)
          . "$PROJECTPATH/.warp/bin/start_help.sh"
        ;;
    esac
}