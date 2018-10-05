#!/bin/bash

function warp_message()
{
    echo -e "$1"
}

function warp_message_error()
{
    echo -e "\e[91m$1\e[0m"
}

function warp_message_ok()
{
    echo -e "\e[92m$1\e[0m"
}

function warp_message_info()
{
    echo -e "\e[96m$1\e[0m"
}

function warp_message_info2()
{
    echo -e "\e[90m$1\e[0m"
}

function warp_message_warn()
{
    echo -e "\e[93m$1\e[0m"
}

function warp_message_bold()
{
    echo -e "\e[1m$1\e[21m"
}


