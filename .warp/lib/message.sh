#!/bin/bash

function warp_message()
{
    printf "$1\n"
}

function warp_message_error()
{
    warp_message "\e[91m$1\e[0m"
}

function warp_message_ok()
{
    warp_message "\e[92m$1\e[0m"
}

function warp_message_info()
{
    warp_message "\e[96m$1\e[0m"
}

function warp_message_info2()
{
    warp_message "\e[90m$1\e[0m"
}

function warp_message_warn()
{
    warp_message "\e[93m$1\e[0m"
}

function warp_message_bold()
{
    warp_message "\e[1m$1\e[21m"
}


