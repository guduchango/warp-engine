#!/bin/bash

function reset_help_usage()
{
    warp_message ""
    warp_message_info "Usage:"
    warp_message      " warp reset command [options] [arguments]"
    warp_message ""

    warp_message ""
    warp_message_info "Options:"
    warp_message_info   " -h, --help         $(warp_message 'display this help message')"
    warp_message_info   " --hard             $(warp_message 'display this help message')"
    warp_message ""

    warp_message_info "Available commands:"

    warp_message_info   " project            $(warp_message 'display info available')"

    warp_message ""
    warp_message_info "Help:"
    warp_message " warp reset project --help"

    warp_message ""
}

function reset_project_help()
{
    warp_message " Reset Projects --hard"
}

function reset_help()
{
    warp_message_info   " reset              $(warp_message 'Reset current Projects to default')"
}
