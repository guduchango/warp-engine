#!/bin/bash +x

echo ""
warp_message_info "Configurando el Servicio de MySQL"

respuesta=$( warp_question_ask_default "Queres agregar un servicio MySQL? $(warp_message_info [Y/n]) " "Y" )
if [ "$respuesta" = "Y" ] || [ "$respuesta" = "y" ]
then
    warp_message_info2 "Podes chequear las versiones de MySQL disponibles acá: $(warp_message_info '[ https://hub.docker.com/r/library/mysql/ ]')"
  
    mysql_version=$( warp_question_ask_default "Cual es la version de MySQL que vas a usar? $(warp_message_info [5.7]) " "5.7" )
    warp_message_info2 "Version de MySQL Seleccionada: $mysql_version"

    while : ; do
        mysql_name_database=$( warp_question_ask_default "Cual es el nombre de la base de datos? $(warp_message_info [warp_db]) " "warp_db" )

        if [ ! $mysql_name_database = 'root' ] ; then
            warp_message_info2 "Base de datos creada: $mysql_name_database"
            break
        else 
            warp_message_warn "El nombre de la base de datos no puede ser $(warp_message_bold root)"
        fi;
    done

    while : ; do
        mysql_user_database=$( warp_question_ask_default "Cual es el usuario de la base de datos? $(warp_message_info [warp]) " "warp" )
        
        if [ ! $mysql_user_database = 'root' ] ; then
            warp_message_info2 "El usuario de la base de datos $mysql_name_database en MySQL es: $mysql_user_database"
            break
        else 
            warp_message_warn "El usuario de la base de datos $mysql_name_database no puede ser $(warp_message_bold root)"
        fi;
    done

    while : ; do
        mysql_password_database=$( warp_question_ask_default "Cual es el password de la base de datos? $(warp_message_info [Summa2009]) " "Summa2009" )
        
        if [ ! $mysql_password_database = 'root' ] ; then
            warp_message_info2 "Password de la base de datos $mysql_name_database es: $mysql_password_database"
            break
        else 
            warp_message_warn "El password de la base de datos $mysql_name_database no puede ser $(warp_message_bold root)"
        fi;
    done

    while : ; do
        mysql_binded_port=$( warp_question_ask_default "Mapeo del puerto 3306 del contenedor al puerto de tu maquina (host)? $(warp_message_info [3306]) " "3306" )

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

    cat $PROJECTPATH/.warp/setup/mysql/tpl/database.yml >> $DOCKERCOMPOSEFILE
    cat $PROJECTPATH/.warp/setup/mysql/tpl/database_enviroment_root.yml >> $DOCKERCOMPOSEFILE

    echo "# MySQL Configuration" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "MYSQL_VERSION=$mysql_version" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "MYSQL_CONFIG_FILE=$mysql_config_file" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "DATABASE_BINDED_PORT=$mysql_binded_port" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "DATABASE_ROOT_PASSWORD=$mysql_root_password" >> $ENVIRONMENTVARIABLESFILESAMPLE

    cat $PROJECTPATH/.warp/setup/mysql/tpl/database_enviroment_default.yml >> $DOCKERCOMPOSEFILE
    echo "DATABASE_NAME=$mysql_name_database" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "DATABASE_USER=$mysql_user_database" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "DATABASE_PASSWORD=$mysql_password_database" >> $ENVIRONMENTVARIABLESFILESAMPLE

    cat $PROJECTPATH/.warp/setup/mysql/tpl/database_volumes_networks.yml >> $DOCKERCOMPOSEFILE

    cp -R ./.warp/setup/mysql/config/ ./.warp/docker/config/mysql/
fi; 

