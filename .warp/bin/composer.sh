#!/bin/bash

function copy_ssh_id() {
	docker-compose -f $DOCKERCOMPOSEFILE exec php bash -c "mkdir -p /var/www/.ssh/"
	docker cp $HOME/.ssh/id_rsa "$(docker-compose -f $DOCKERCOMPOSEFILE ps -q php)":/var/www/.ssh/id_rsa
	docker-compose -f $DOCKERCOMPOSEFILE exec --user=root php bash -c "chown -R www-data:www-data /var/www/.ssh/id_rsa"
}

function composer() {

  if [ $(isRunning) = false ]; then
    echo >&2 "Warp framework Not running";
    exit 1;
  fi

  copy_ssh_id

  if [ "$1" = "-T" ]; then
    shift 1
    docker-compose -f $DOCKERCOMPOSEFILE exec -T php bash -c "composer $@"
  else
    docker-compose -f $DOCKERCOMPOSEFILE exec php bash -c "composer $@"
  fi;
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

function composer_main()
{
    case "$1" in
        composer)
		      shift 1
          composer $*  
        ;;

        *)
		      . "$PROJECTPATH/.warp/bin/composer_help.sh"
        ;;
    esac
}
