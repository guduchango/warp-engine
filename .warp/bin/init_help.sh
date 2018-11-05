#!/bin/bash

function init_help_usage()
{
    warp_message ""
    warp_message_info "Usage:"
    warp_message      " warp init [options]"
    warp_message ""

    warp_message ""
    warp_message_info "Options:"
    warp_message_info   " -h, --help         $(warp_message 'display this help message')"
    warp_message ""

    warp_message ""
    warp_message_info "Help:"
    warp_message " this command is used to initialize a wizard with options to create containers"
    warp_message ""
    warp_message ""

    # TODO translate to English

    warp_message "Cuando se ejecuta por primera vez detecta si ya fue instalado, y sino comienza la instalacion del framework"
    warp_message "Luego de la instalacion inicial aparece un menú guiado con opciones para crear servicios"
    warp_message "Se pueden configurar los siguientes servicios:"
    warp_message "1) Servidor Web con Nginx"
    warp_message "2) Servicio de PHP"
    warp_message "3) Base de datos con MySQL"
    warp_message "4) Servicio de elasticsearch"
    warp_message "5) Servicio de Redis para cache, session, fpc"
    warp_message ""
    warp_message "Si el programa detecta que hay una configuracion previa, muestra un menu más corto de opciones, para configurar:"
    warp_message "1) Trabajar con uno o varios projectos en paralelo"
    warp_message "2) Configurar puertos de MySQL"
    warp_message ""
    warp_message "para comenzar ejecute ./warp init"
    warp_message ""

}

function init_help()
{
    warp_message_info   " init               $(warp_message 'run main command to prepare project')"

}
