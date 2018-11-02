warp_message "* Configurando archivos de variables de entorno $(warp_message_ok [ok])"
 [ ! -f $ENVIRONMENTVARIABLESFILE ] && cp $ENVIRONMENTVARIABLESFILESAMPLE $ENVIRONMENTVARIABLESFILE

if [ ! -z $WARP_DETECT_MODE_TL ] ; then

    #  CHECK IF GITIGNOREFILE CONTAINS FILES WARP TO IGNORE
    [ -f $GITIGNOREFILE ] && cat $GITIGNOREFILE | grep --quiet -w "^# WARP FRAMEWORK"

    # Exit status 0 means string was found
    # Exit status 1 means string was not found
    if [ $? = 1 ] || [ ! -f $GITIGNOREFILE ]
    then
        warp_message "* Preparando archivos para .gitignore $(warp_message_ok [ok])"
        # FILES TO ADD GITIGNORE
        echo "# WARP FRAMEWORK"  >> $GITIGNOREFILE
        echo "!/warp"            >> $GITIGNOREFILE
        echo "!/$(basename $WARPFOLDER)"                      >> $GITIGNOREFILE
        echo "/$(basename $ENVIRONMENTVARIABLESFILE)"         >> $GITIGNOREFILE
        echo "!/$(basename $ENVIRONMENTVARIABLESFILESAMPLE)"  >> $GITIGNOREFILE
        echo "!/$(basename $DOCKERCOMPOSEFILE)"  >> $GITIGNOREFILE
        echo "/.warp/docker/volumes"             >> $GITIGNOREFILE
    fi
fi

if [ -d $PROJECTPATH/.warp ]; then
    warp_message "* Directorio .warp $(warp_message_ok [ok])"
else
    warp_message "* Directorio .warp $(warp_message_error [error])"
fi

warp_message "* Aplicando permisos a subdirectorios .warp/docker/volumes $(warp_message_ok [ok])"

    # SET PERMISSIONS FOLDERS
    mkdir -p $PROJECTPATH/.warp/docker/volumes/nginx/logs
    chmod -R 777 $PROJECTPATH/.warp/docker/volumes/nginx

if [ ! -f $WARP_BINARY_FILE ] ; then
    warp_message "* Creando archivo binario warp $(warp_message_ok [ok])"
    warp_binary_create
fi

warp_message ""

warp_message_warn "Para iniciar los contenedores: $(warp_message_bold './warp start')"
warp_message_warn "Para más información: $(warp_message_bold './warp help')"
sleep 1
