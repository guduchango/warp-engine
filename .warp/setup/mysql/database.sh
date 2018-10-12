#!/bin/bash +x

echo ""
warp_message_info "Configurando el Servicio de MySQL"

respuesta=$( warp_question_ask_default "Queres agregar un servicio MySQL? $(warp_message_info [Y/n]) " "Y" )
if [ "$respuesta" = "Y" ] || [ "$respuesta" = "y" ]
then
  
    basedefault=0 #False
    mysql_version=$( warp_question_ask_default "Cual es la version de MySQL que vas a usar? $(warp_message_info [5.7]) " "5.7" )
    warp_message_info2 "Version de MySQL Seleccionada: $mysql_version"

    resp_database_default=$( warp_question_ask_default "Queres crear una base de datos por defecto? $(warp_message_info [Y/n]) " "Y" )
    if [ "$resp_database_default" = "Y" ] || [ "$resp_database_default" = "y" ]
    then
        usedatabase=1 #True
    fi;

    if [ $usedatabase = 1 ]; then
        mysql_name_database=$( warp_question_ask_default "Cual es el nombre de la base de datos? $(warp_message_info [magento2]) " "magento2" )
        warp_message_info2 "Base de datos por defecto: $mysql_name_database"
        
        mysql_user_database=$( warp_question_ask_default "Cual es el usuario de la base de datos? $(warp_message_info [magento]) " "magento" )
        warp_message_info2 "Usuario de base de datos MySQL: $mysql_user_database"

        mysql_password_database=$( warp_question_ask_default "Cual es el password de la base de datos? $(warp_message_info [Summa2009]) " "Summa2009" )
        warp_message_info2 "Password base de datos MySQL: $mysql_password_database"
    fi;

    while : ; do
        mysql_binded_port=$( warp_question_ask_default "Cual es el puerto de conexion a MySQL? $(warp_message_info [3306]) " "3306" )

        #CHECK si port es numero antes de llamar a warp_net_port_in_use
        if ! warp_net_port_in_use $mysql_binded_port ; then
            warp_message_info2 "El puerto seleccionado es: $mysql_binded_port, el mapeo de puertos es: $(warp_message_bold '127.0.0.1:'$mysql_binded_port' ---> localhost:'$mysql_binded_port)"
            break
        else
            warp_message_warn "El puerto $mysql_binded_port esta ocupado, elige otro\n"
        fi;
    done

    mysql_root_password=$( warp_question_ask_default "Cual es la contraseña del Usuario root de MySQL? $(warp_message_info [root]) " "root" )
    warp_message_info2 "Password de usuario root: $mysql_root_password"
    mysql_config_file=$( warp_question_ask_default "Archivo de configuracion de MySQL? $(warp_message_info [./.warp/docker/config/mysql/conf.d]) " "./.warp/docker/config/mysql/conf.d" )
    warp_message_info2 "Archivo de configuracion seleccionado: $mysql_config_file"

    cat $PROJECTPATH/.warp/setup/mysql/tpl/database.yml >> $PROJECTPATH/docker-compose.yml
    cat $PROJECTPATH/.warp/setup/mysql/tpl/database_enviroment_root.yml >> $PROJECTPATH/docker-compose.yml

    if [ $usedatabase = 1 ]; then
        cat $PROJECTPATH/.warp/setup/mysql/tpl/database_enviroment_default.yml >> $PROJECTPATH/docker-compose.yml
        echo "DATABASE_NAME=$mysql_name_database" >> $PROJECTPATH/.env
        echo "DATABASE_USER=$mysql_user_database" >> $PROJECTPATH/.env
        echo "DATABASE_PASSWORD=$mysql_password_database" >> $PROJECTPATH/.env
    fi;

    cat $PROJECTPATH/.warp/setup/mysql/tpl/database_volumes_networks.yml >> $PROJECTPATH/docker-compose.yml

    echo "MYSQL_VERSION=$mysql_version" >> $PROJECTPATH/.env
    echo "DATABASE_ROOT_PASSWORD=$mysql_root_password" >> $PROJECTPATH/.env
    echo "DATABASE_BINDED_PORT=$mysql_binded_port" >> $PROJECTPATH/.env
    echo "MYSQL_CONFIG_FILE=$mysql_config_file" >> $PROJECTPATH/.env

    cp -R ./.warp/setup/mysql/config/conf.d ./.warp/docker/config/mysql
fi; 

