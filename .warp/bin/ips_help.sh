#!/bin/bash

function ips_help_usage()
{
    warp_message ""
    warp_message_info "Usage:"
    warp_message      " warp ips [options] [service_name]"
    warp_message ""

    warp_message ""
    warp_message_info "Options:"
    warp_message_info   " -h, --help         $(warp_message 'display this help message')"
    warp_message ""

    warp_message ""
    warp_message_info "Help:"
    warp_message " allows to see containers ip and name of each service, for example php, redis, elasticsearch, web, mysql  "
    warp_message " if not specify any service shows all containers ips"
    warp_message ""

    warp_message_info "Example:"
    warp_message " warp ips"
    warp_message " warp ips php"
    warp_message ""    
}

function ips_help()
{
    warp_message_info   " ips                $(warp_message 'view ips and names from containers')"
}
