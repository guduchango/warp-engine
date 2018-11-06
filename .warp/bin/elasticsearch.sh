#!/bin/bash

    # IMPORT HELP

    . "$PROJECTPATH/.warp/bin/elasticsearch_help.sh"

function elasticsearch_info()
{
    ES_VERSION=$(warp_env_read_var ES_VERSION)

    if [ ! -z "$ES_VERSION" ]
    then
        warp_message ""
        warp_message_info "* Elasticsearch Info"
        warp_message "ES_VERSION:                 $(warp_message_info $ES_VERSION)"
        warp_message "ES_INTERNAL_PORT:           $(warp_message_info 'elasticsearch:9200, elasticsearch:9300')"
        warp_message "ES_DATA:                    $(warp_message_info $PROJECTPATH/.warp/docker/volumes/elasticsearch)"

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
