#!/bin/bash

##
# Print the WARP banner
# Use:
#    warp_banner
#
# Globals:
#   WARP_VERSION
#   WARP_COMMIT
# Arguments:
#   None
# Returns:
#   None
##
function warp_banner()
{
    echo ""
    echo -e "\e[96m ___ ____     ____        _____\e[0m"
    echo -e "\e[96m____      ___      ______      ___\e[0m"
    echo -e "\e[96m     _  ___  __    ___        ____\e[0m"
    echo -e "\e[96m___ | |     / /___ __________       ____\e[0m"
    echo -e "\e[96m    | | /| / / __ \`/ ___/ __ \\ __    ___\e[0m"
    echo -e "\e[96m___ | |/ |/ / /_/ / /  / /_/ / __  ___\e[0m"
    echo -e "\e[96m_   |__/|__/\__,_/_/  / .___/    ___   ____\e[0m"
    echo -e "\e[96m __   ___    ____    /_/  ___   __   __ \e[0m"
    echo -e "\e[96m     ____     ___   ____  __   ______\e[0m"
    echo -e "\e[96m____      ___      ______    ____   ____ \e[0m"
    echo ""
    echo -e "\e[96mWARP ENGINE\e[0m - Speeding up! your development infraestructure"
    echo "Version: $WARP_VERSION"
    echo "Commit version: $WARP_COMMIT"
    echo ""
}