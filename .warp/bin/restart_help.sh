#!/bin/bash

function start_help_usage()
{
    warp_message ""
    warp_message_info "Usage:"
    warp_message      " warp restart [options]"
    warp_message ""

    warp_message ""
    warp_message_info "Options:"
    warp_message_info   " -h, --help         $(warp_message 'display this help message')"
    warp_message ""

    warp_message ""
    warp_message_info "Help:"
    warp_message " this command is used to restart the services"
    warp_message ""

}

function start_help()
{
    warp_message ""
}