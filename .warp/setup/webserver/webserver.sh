#!/bin/bash

warp_message_info "Configurando el Servidor Web - Nginx"

respuesta=$( warp_question_ask_default "Queres agregar un servidor web (Nginx)? $(warp_message_info [Y/n]) " "Y" )
if [ "$respuesta" = "Y" ] || [ "$respuesta" = "y" ]
then
  
  #cat $PROJECTPATH/.warp/setup/webserver/tpl/webserver.yml
  #cat $PROJECTPATH/.warp/setup/webserver/tpl/webserver.env

    while : ; do
        echo ""
        http_port=$( warp_question_ask_default "Mapeo del puerto 80 del contenedor al puerto de tu maquina (host)? $(warp_message_info [80]) " "80" )

        #CHECK si port es numero antes de llamar a warp_net_port_in_use
        if ! warp_net_port_in_use $http_port ; then
            warp_message_info2 "El puerto seleccionado es: $http_port, el mapeo de puertos es: $(warp_message_bold '127.0.0.1:'$http_port' ---> container_ip:80')"
            break
        else
            warp_message_warn "El puerto $http_port esta ocupado, elige otro\n"
        fi;
    done
    
    while : ; do
        https_port=$( warp_question_ask_default "En que puerto queres levantar el Webserver HTTPS? $(warp_message_info [443]) " "443" )

        if ! warp_net_port_in_use $https_port ; then
            warp_message_info2 "El puerto seleccionado es: $https_port, el mapeo de puertos es: $(warp_message_bold '127.0.0.1:'$https_port' ---> container_ip:443')"
            break
        else
            warp_message_warn "El puerto $https_port esta ocupado, elige otro\n"
        fi;
    done
    
    nginx_virtual_host=$( warp_question_ask_default "Cual es el virtual host? $(warp_message_info [local.sample.com]) " "local.sample.com" )
    nginx_config_file=$( warp_question_ask_default "Archivo de configuracion de Nginx? $(warp_message_info [./.warp/docker/config/nginx/sites-enabled/default.conf]) " "./.warp/docker/config/nginx/sites-enabled/default.conf" )
    

  # Nginx Configuration
    # VIRTUAL_HOST=local.sample.com
    # NGINX_CONFIG_FILE=./warp/config/nginx/sites-enabled/default.conf
  




fi; 

