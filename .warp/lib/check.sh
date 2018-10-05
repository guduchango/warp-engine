#!/bin/bash

##
# Check if the .env file exist
#
# Globals:
#   PROJECTPATH
# Arguments:
#   None
# Returns:
#   0 if exists
#   1 if not exists
##
warp_check_env_file()
{
    if [ -f $PROJECTPATH/.env ]; then
        return 0 #TRUE
    else
        return 1 #FALSE
    fi;
}


##
# Check if the docker-compose.yml file exist
#
# Globals:
#   PROJECTPATH
# Arguments:
#   None
# Returns:
#   0 if exists
#   1 if not exists
##
warp_check_yaml_file()
{
    if [ -f $PROJECTPATH/docker-compose.yml ]; then
        return 0 #TRUE
    else
        return 1 #FALSE
    fi;
}