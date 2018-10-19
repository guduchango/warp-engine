#!/bin/bash

warp_message_info "Utility for controlling dockerized projects\n"

warp_message_warn "Usage:"
warp_message      " command [options] [arguments]"
warp_message ""

warp_message ""
warp_message_warn "Options:"
warp_message_ok   " -h, --help         $(warp_message 'display this help message')"
warp_message ""

warp_message_warn "Available commands:"

warp_message_ok   " init               $(warp_message 'run main command to prepare project')"
warp_message_ok   " start              $(warp_message 'start the server and all of its components')"
warp_message_ok   " stop               $(warp_message 'stop the server and all of its components')"
warp_message_ok   " restart            $(warp_message 'restart the server')"
warp_message_ok   " ps                 $(warp_message 'list containers')"
warp_message_ok   " logs               $(warp_message 'view logs containers')"
warp_message ""
