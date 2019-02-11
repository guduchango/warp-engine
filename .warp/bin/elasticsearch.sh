#!/bin/bash

    # IMPORT HELP

    . "$PROJECTPATH/.warp/bin/elasticsearch_help.sh"

function elasticsearch_info()
{

    if ! warp_check_env_file ; then
        warp_message_error "file not found $(basename $ENVIRONMENTVARIABLESFILE)"
        exit
    fi; 

    ES_VERSION=$(warp_env_read_var ES_VERSION)

    if [ ! -z "$ES_VERSION" ]
    then
        warp_message ""
        warp_message_info "* Elasticsearch"
        warp_message "Version:                    $(warp_message_info $ES_VERSION)"
        warp_message "Host:                       $(warp_message_info 'elasticsearch')"
        warp_message "Ports (container):          $(warp_message_info '9200, 9300')"
        warp_message "Data:                       $(warp_message_info $PROJECTPATH/.warp/docker/volumes/elasticsearch)"

        warp_message ""
    fi

}

function elasticsearch_command()
{

    if [ "$1" = "-h" ] || [ "$1" = "--help" ]
    then
        elasticsearch_help_usage 
        exit 1
    fi;

}

function elasticsearch_main()
{
    case "$1" in
        elasticsearch)
		      shift 1
          elasticsearch_command $*  
        ;;

        info)
            elasticsearch_info
        ;;

        -h | --help)
            elasticsearch_help_usage
        ;;

        *)
		    elasticsearch_help_usage
        ;;
    esac
}
