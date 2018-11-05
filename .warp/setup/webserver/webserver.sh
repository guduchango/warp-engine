#!/bin/bash +x

warp_message ""
warp_message_info "Configurando el Servidor Web - Nginx"
warp_message ""

    warp_check_os_mac

while : ; do
    respuesta=$( warp_question_ask_default "Queres agregar un servidor web (Nginx)? $(warp_message_info [Y/n]) " "Y" )

    if [ "$respuesta" = "Y" ] || [ "$respuesta" = "y" ] || [ "$respuesta" = "N" ] || [ "$respuesta" = "n" ] ; then
        break
    else
        warp_message_warn "Respuesta Incorrecta, debe seleccionar entre dos opciones: $(warp_message_info [Y/n]) "
    fi
done

if [ "$respuesta" = "Y" ] || [ "$respuesta" = "y" ]
then

    nginx_virtual_host=$( warp_question_ask_default "Cual es el virtual host? $(warp_message_info [local.sample.com]) " "local.sample.com" )
  
    useproxy=1 #False

    case "$(uname -s)" in
        Linux)
            resp_reverse_proxy=$( warp_question_ask_default "Queres configurar una ip estatica para soportar mas de un proyecto en paralelo? $(warp_message_info [y/N]) " "N" )
            if [ "$resp_reverse_proxy" = "Y" ] || [ "$resp_reverse_proxy" = "y" ]
            then
                # autodetect docker in linux
                useproxy=0 #True
            fi;
        ;;
    esac

    if [ $useproxy = 1 ]; then
        while : ; do
            http_port=$( warp_question_ask_default "Mapeo del puerto 80 del contenedor al puerto de tu maquina (host)? $(warp_message_info [80]) " "80" )

            #CHECK si port es numero antes de llamar a warp_net_port_in_use
            if ! warp_net_port_in_use $http_port ; then
                warp_message_info2 "El puerto seleccionado es: $http_port, el mapeo de puertos es: $(warp_message_bold '127.0.0.1:'$http_port' ---> container_ip:'$http_port)"
                break
            else
                warp_message_warn "El puerto $http_port esta ocupado, elige otro\n"
            fi;
        done

        while : ; do
            https_port=$( warp_question_ask_default "Mapeo del puerto 443 del contenedor al puerto de tu maquina (host)? $(warp_message_info [443]) " "443" )

            if ! warp_net_port_in_use $https_port ; then
                warp_message_info2 "El puerto seleccionado es: $https_port, el mapeo de puertos es: $(warp_message_bold '127.0.0.1:'$https_port' ---> container_ip:'$https_port)"
                break
            else
                warp_message_warn "El puerto $https_port esta ocupado, elige otro\n"
            fi;
        done
    else 
        while : ; do
            http_container_ip=$( warp_question_ask_default "Ingrese numero de IP para asignar al contenedor? $(warp_message_info '[rango 172.50.0.'$MIN_RANGE_IP' - 172.50.0.255]') " "172.50.0.$MIN_RANGE_IP" )

            if warp_check_range_ip $http_container_ip ; then
                RANGE=$(echo $http_container_ip | cut -f1 -f2 -f3 -d .)
                warp_message_warn "Debe seleccionar una IP entre: $RANGE.$MIN_RANGE_IP y $RANGE.255\n"
            else 
                if ! warp_net_ip_in_use $http_container_ip ; then
                    warp_message_info2 "La IP seleccionada es: $http_container_ip, la configuracion para el archivo /etc/hosts es: $(warp_message_bold $http_container_ip' '$nginx_virtual_host)"
                    break
                else
                    warp_message_warn "La IP $http_container_ip esta ocupada en otro proyecto, elija otra\n"
                fi;
            fi;
        done
    fi; 

    
    nginx_config_file=$( warp_question_ask_default "Cual es el nombre del archivo de configuracion de Nginx? $(warp_message_info '['$nginx_virtual_host'.conf]') " "$nginx_virtual_host.conf" )
    
    echo "" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "# NGINX Configuration" >> $ENVIRONMENTVARIABLESFILESAMPLE

    cat $PROJECTPATH/.warp/setup/webserver/tpl/webserver.yml >> $DOCKERCOMPOSEFILE

    if [ $useproxy = 0 ]; then
        echo "HTTP_BINDED_PORT=80" >> $ENVIRONMENTVARIABLESFILESAMPLE
        echo "HTTPS_BINDED_PORT=443" >> $ENVIRONMENTVARIABLESFILESAMPLE
        echo "HTTP_HOST_IP=$http_container_ip" >> $ENVIRONMENTVARIABLESFILESAMPLE
    else
        echo "HTTP_BINDED_PORT=$http_port" >> $ENVIRONMENTVARIABLESFILESAMPLE
        echo "HTTPS_BINDED_PORT=$https_port" >> $ENVIRONMENTVARIABLESFILESAMPLE
        echo "HTTP_HOST_IP=0.0.0.0" >> $ENVIRONMENTVARIABLESFILESAMPLE
    fi;

    echo "VIRTUAL_HOST=$nginx_virtual_host" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "NGINX_CONFIG_FILE=./.warp/docker/config/nginx/sites-enabled/$nginx_config_file" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "" >> $ENVIRONMENTVARIABLESFILESAMPLE

    mkdir -p $PROJECTPATH/.warp/docker/volumes/nginx/logs
    chmod -R 777 $PROJECTPATH/.warp/docker/volumes/nginx

    cp -R $PROJECTPATH/.warp/setup/webserver/config/nginx $PROJECTPATH/.warp/docker/config/nginx
    cp $PROJECTPATH/.warp/docker/config/nginx/sites-enabled/default.conf $PROJECTPATH/.warp/docker/config/nginx/sites-enabled/$nginx_config_file
fi; 

