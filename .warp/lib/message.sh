#!/bin/bash

# ANSI color codes
RS="\e[\033[0m"    # reset
HC="\e[\033[1m"    # hicolor
UL="\e[\033[4m"    # underline
INV="\e[\033[7m"   # inverse background and foreground
FBLK="\e[\033[30m" # foreground black
FRED="\e[\033[31m" # foreground red
FGRN="\e[\033[32m" # foreground green
FYEL="\e[\033[33m" # foreground yellow
FBLE="\e[\033[34m" # foreground blue
FMAG="\e[\033[35m" # foreground magenta
FCYN="\e[\033[36m" # foreground cyan
FWHT="\e[\033[37m" # foreground white
FGRY="\e[\033[90m" # foreground gray
BBLK="\e[\033[40m" # background black
BRED="\e[\033[41m" # background red
BGRN="\e[\033[42m" # background green
BYEL="\e[\033[43m" # background yellow
BBLE="\e[\033[44m" # background blue
BMAG="\e[\033[45m" # background magenta
BCYN="\e[\033[46m" # background cyan
BWHT="\e[\033[47m" # background white

function warp_message()
{
    printf "$1\n"
}

function warp_message_error()
{
    warp_message "$FRED $1 $RS"
}

function warp_message_ok()
{
    warp_message "$FGRN $1 $RS"
}

function warp_message_info()
{
    warp_message "$FCYN $1 $RS"
}

function warp_message_info2()
{
    warp_message "$FGRY $1 $RS"
}

function warp_message_warn()
{
    warp_message "$FYEL $1 $RS"
}

function warp_message_bold()
{
    warp_message "$HC $1 $RC"
}


