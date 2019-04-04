#!/bin/bash

    # IMPORT HELP

    . "$PROJECTPATH/.warp/bin/fix_help.sh"

function fix_add_user()
{
    case "$(uname -s)" in
      Darwin)
        warp_message "* this command is not necessary for macOS $(warp_message_ok [ok])"
      ;;
      Linux)
        warp_message "* Adding host user: $(whoami) to docker and www-data groups $(warp_message_ok [ok])"

        # add user docker to current user
        sudo usermod -aG docker $(whoami)

        # add ID user 33 (www-data inside container) to current user
        sudo usermod -aG 33 $(whoami)

      ;;
    esac

    exit 1;
}

function fix_permissions() 
{

    if [ "$1" = "-h" ] || [ "$1" = "--help" ]
    then
        fix_help_usage 
        exit 1
    fi;

    if [ "$1" = "--addUser" ]
    then
        fix_add_user 
        exit 1
    fi;

    if [ $(warp_check_is_running) = false ]; then
        warp_message_error "The containers are not running"
        warp_message_error "please, first run warp start"

        exit 1;
    fi
    
    # fix user and groups to current project
    warp_message "* Applying user: $(whoami) and group: www-data to files and folders $(warp_message_ok [ok])"
    sudo chown -R $(whoami):33 $(ls)

    warp_message "* Make folders traversable and read/write $(warp_message_ok [ok])"
    sudo find $(ls) -type d -exec chmod ug+rwx {} \; # Make folders traversable and read/write

    warp_message "* Make files read/write $(warp_message_ok [ok])"
    sudo find $(ls) -type f -exec chmod a+rw {} \;  # Make files read/write

    warp_message "* Applying permissions to subdirectories .warp/docker/volumes $(warp_message_ok [ok])"

    # add permission MySQL 999 (mysql inside the container)
    # [ -d $PROJECTPATH/.warp/docker/volumes/mysql/ ] && sudo chown -R 999:999 $PROJECTPATH/.warp/docker/volumes/mysql/

    # add permission elasticsearch inside the container    
    [ -d $PROJECTPATH/.warp/docker/volumes/elasticsearch/ ] && sudo chmod -R a+rwx $PROJECTPATH/.warp/docker/volumes/elasticsearch/

    warp_message "* Applying permissions to binaries $(warp_message_ok [ok])"
    # restart correct permissions to warp and binaries
    [ -f $PROJECTPATH/warp ] && sudo chmod a+x $PROJECTPATH/warp
    [ -d $PROJECTPATH/bin ] && sudo chmod a+x $PROJECTPATH/bin/*
}

function fix_main()
{
    case "$1" in
        fix)
            shift 1
            fix_permissions $*
        ;;

        -h | --help)
            fix_help_usage
        ;;

        --addUser)
            fix_add_user
        ;;

        *)            
            fix_help_usage
        ;;
    esac
}