#!/bin/bash

    # IMPORT HELP

    . "$PROJECTPATH/.warp/bin/composer_help.sh"

function copy_ssh_id() {
  if [ -f $HOME/.ssh/id_rsa ] ; then
    docker-compose -f $DOCKERCOMPOSEFILE exec php bash -c "mkdir -p /var/www/.ssh/"
    docker cp $HOME/.ssh/id_rsa "$(docker-compose -f $DOCKERCOMPOSEFILE ps -q php)":/var/www/.ssh/id_rsa
    docker-compose -f $DOCKERCOMPOSEFILE exec --user=root php bash -c "chown -R www-data:www-data /var/www/.ssh/id_rsa"
  fi;
}

function composer() {

  if [ $(warp_check_is_running) = false ]; then
    warp_message_error "Los contenedores no estan corriendo"
    warp_message_error "este comando necesita previamente que ejecutes warp start"

    exit 1;
  fi

  if [ "$1" = "-h" ] || [ "$1" = "--help" ] ; then
        
      composer_help_usage
  elif [ "$1" = "--credential" ] ; then
      warp_message "copying credentials"
      copy_ssh_id
      warp_message "Done!"
  else

    if [ "$1" = "-T" ]; then
      shift 1
      docker-compose -f $DOCKERCOMPOSEFILE exec -T php bash -c "composer $@"
    else
      docker-compose -f $DOCKERCOMPOSEFILE exec php bash -c "composer $@"
    fi;
  fi;
}

function composer_main()
{
    case "$1" in
        composer)
		      shift 1
          composer $*  
        ;;

        *)
		      composer_help_usage
        ;;
    esac
}
