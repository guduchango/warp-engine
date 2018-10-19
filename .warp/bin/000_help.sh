#!/bin/bash

warp_message_info "Utility for controlling dockerized projects\n"

warp_message_warn "Usage:"
warp_message      " command [options] [arguments]"
warp_message ""

warp_message ""
warp_message_warn "Options:"
warp_message_ok   " -h, --help         $(warp_message 'Display this help message')"
warp_message ""

warp_message_warn "Available commands:"

warp_message_ok   " start              $(warp_message 'Start the server and all of its components')"
warp_message_ok   " stop               $(warp_message 'Stop the server and all of its components')"
warp_message_ok   " restart            $(warp_message 'Restart the server')"
warp_message_ok   " ps                 $(warp_message 'List containers')"
warp_message_ok   " logs               $(warp_message 'View logs containers')"
warp_message ""

warp_message_ok   " mysql              $(warp_message 'Utility for connect with databases')"
warp_message_ok   " redis              $(warp_message 'Service of redis')"
warp_message_ok   " php                $(warp_message 'Service of php')"
warp_message_ok   " composer           $(warp_message 'Ejecute composer inside container')"
warp_message_ok   " elasticsearch      $(warp_message 'Container for this help message')"

warp_message ""
warp_message_warn "Help:"
warp_message " warp mysql --help"
