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

warp_message_ok   " mysql              $(warp_message 'utility for connect with databases')"
warp_message_ok   " redis              $(warp_message 'service of redis')"
warp_message_ok   " php                $(warp_message 'service of php')"
warp_message_ok   " composer           $(warp_message 'ejecute composer inside container')"
warp_message_ok   " elasticsearch      $(warp_message 'container for this help message')"

warp_message ""
warp_message_warn "Help:"
warp_message " warp mysql --help"
