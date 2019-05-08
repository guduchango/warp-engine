warp_message "* Configuring environment variable files $(warp_message_ok [ok])"
 [ ! -f $ENVIRONMENTVARIABLESFILE ] && cp $ENVIRONMENTVARIABLESFILESAMPLE $ENVIRONMENTVARIABLESFILE
 [ ! -f $DOCKERCOMPOSEFILE ] && cp $DOCKERCOMPOSEFILESAMPLE $DOCKERCOMPOSEFILE

# creating ext-xdebug.ini
if  [ ! -f $PROJECTPATH/.warp/docker/config/php/ext-xdebug.ini ]
then
    cp $PROJECTPATH/.warp/docker/config/php/ext-xdebug.ini.sample $PROJECTPATH/.warp/docker/config/php/ext-xdebug.ini
fi

if [ ! -z $WARP_DETECT_MODE_TL ] ; then

    #  CHECK IF GITIGNOREFILE CONTAINS FILES WARP TO IGNORE
    [ -f $GITIGNOREFILE ] && cat $GITIGNOREFILE | grep --quiet -w "^# WARP FRAMEWORK"

    # Exit status 0 means string was found
    # Exit status 1 means string was not found
    if [ $? = 1 ] || [ ! -f $GITIGNOREFILE ]
    then
        warp_message "* Preparing files for .gitignore $(warp_message_ok [ok])"
        # FILES TO ADD GITIGNORE
        echo "# WARP FRAMEWORK"  >> $GITIGNOREFILE
        echo "!/warp"            >> $GITIGNOREFILE
        echo "!/$(basename $WARPFOLDER)"                      >> $GITIGNOREFILE
        echo "/$(basename  $ENVIRONMENTVARIABLESFILE)"        >> $GITIGNOREFILE
        echo "/$(basename  $DOCKERCOMPOSEFILE)"               >> $GITIGNOREFILE
        echo "!/$(basename $DOCKERCOMPOSEFILEMAC)"            >> $GITIGNOREFILE
        echo "!/$(basename $DOCKERSYNCMAC)"                   >> $GITIGNOREFILE
        echo "!/$(basename $ENVIRONMENTVARIABLESFILESAMPLE)"  >> $GITIGNOREFILE
        echo "!/$(basename $DOCKERCOMPOSEFILESAMPLE)"   >> $GITIGNOREFILE
        echo "/.docker-sync"                            >> $GITIGNOREFILE        
        echo "/.warp/docker/volumes"                    >> $GITIGNOREFILE
        echo "/.warp/docker/dumps"                      >> $GITIGNOREFILE
        echo "/.warp/docker/setup"                      >> $GITIGNOREFILE
        echo "/.warp/docker/lib"                        >> $GITIGNOREFILE
        echo "/.warp/docker/bin"                        >> $GITIGNOREFILE
        echo "/.warp/docker/config/php/ext-xdebug.ini"  >> $GITIGNOREFILE
        
    fi
fi

if [ -d $PROJECTPATH/.warp ]; then
    warp_message "* Directory .warp $(warp_message_ok [ok])"
else
    warp_message "* Directory .warp $(warp_message_error [error])"
fi

warp_message "* Applying permissions to subdirectories .warp/docker/volumes $(warp_message_ok [ok])"

    # SET PERMISSIONS FOLDERS
    mkdir -p $PROJECTPATH/.warp/docker/volumes/nginx/logs
    sudo chmod -R 775 $PROJECTPATH/.warp/docker/volumes/nginx
    sudo chgrp -R 33 $PROJECTPATH/.warp/docker/volumes/nginx

    mkdir -p   $PROJECTPATH/.warp/docker/volumes/php-fpm/logs
    [ ! -f $PROJECTPATH/.warp/docker/volumes/php-fpm/logs/access.log ] && sudo touch $PROJECTPATH/.warp/docker/volumes/php-fpm/logs/access.log 
    [ ! -f $PROJECTPATH/.warp/docker/volumes/php-fpm/logs/fpm-error.log ] && sudo touch $PROJECTPATH/.warp/docker/volumes/php-fpm/logs/fpm-error.log 
    [ ! -f $PROJECTPATH/.warp/docker/volumes/php-fpm/logs/fpm-php.www.log ] && sudo touch $PROJECTPATH/.warp/docker/volumes/php-fpm/logs/fpm-php.www.log 
    sudo chmod -R 775 $PROJECTPATH/.warp/docker/volumes/php-fpm
    sudo chgrp -R 33 $PROJECTPATH/.warp/docker/volumes/php-fpm

    mkdir -p   $PROJECTPATH/.warp/docker/volumes/elasticsearch
    sudo chmod -R 777 $PROJECTPATH/.warp/docker/volumes/elasticsearch

if [ ! -f $WARP_BINARY_FILE ] ; then
    warp_message "* Creating binary warp file $(warp_message_ok [ok])"
    sudo sh $PROJECTPATH/.warp/lib/binary.sh $WARP_BINARY_FILE
fi

warp_message ""
if [ ! -z $WARP_DETECT_MODE_TL ] ; then
    NGINX_CONFIG_FILE=$(warp_env_read_var NGINX_CONFIG_FILE)
    warp_message_warn "To complete the Nginx configuration, please edit this file: $(warp_message_bold $NGINX_CONFIG_FILE)"
    warp_message ""
fi

warp_message_warn "To start the containers: $(warp_message_bold './warp start')"
warp_message_warn "To see detailed information for each service configured: $(warp_message_bold './warp info')"
sleep 1
