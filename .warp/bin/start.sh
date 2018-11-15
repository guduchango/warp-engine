#!/bin/bash

    # IMPORT HELP

    . "$PROJECTPATH/.warp/bin/start_help.sh"

# Initialize Cron Job
function run_cron() {

    docker-compose -f $DOCKERCOMPOSEFILE exec --user=root php bash -c "cron"
}

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
    warp_message_warn "the containers is running";
    warp_message_warn "for stop, please run: warp stop";
    exit 1;
  fi

  if [ "$1" = "-h" ] || [ "$1" = "--help" ] ; then
        
      start_help_usage
      exit 1;
  else

    case "$(uname -s)" in
      Darwin)
        # start data sync
        docker-sync start
        # start docker containers in macOS
        docker-compose -f $DOCKERCOMPOSEFILE -f $DOCKERCOMPOSEFILEMAC up -d
      ;;
      Linux)
        # start docker containers in linux
        docker-compose -f $DOCKERCOMPOSEFILE up -d
      ;;
    esac

    if [ $(warp_check_php_is_running) = true ]
    then
      # COPY ID_RSA ./ssh
      copy_ssh_id
      run_cron
    else
      warp_message_warn "Please Run ./warp composer --credential to copy the credentials"
    fi
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
