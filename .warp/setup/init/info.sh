warp_message "* Configurando archivos de variables de entorno $(warp_message_ok [ok])"
 [ ! -f $ENVIRONMENTVARIABLESFILE ] && cp $ENVIRONMENTVARIABLESFILESAMPLE $ENVIRONMENTVARIABLESFILE

    # SET PERMISSIONS FOLDERS
    mkdir -p $PROJECTPATH/.warp/docker/volumes/nginx/logs
    chmod -R 777 $PROJECTPATH/.warp/docker/volumes/nginx
if [ ! -z $WARP_DETECT_MODE_TL ] ; then
    warp_message "* Preparando archivos para .gitignore $(warp_message_ok [ok])"
    # FILES TO ADD GITIGNORE
    echo "# WARN FRAMEWORK"  >> $GITIGNOREFILE
    echo "!/warp"            >> $GITIGNOREFILE
    echo "!/$(basename $WARPFOLDER)"                      >> $GITIGNOREFILE
    echo "/$(basename $ENVIRONMENTVARIABLESFILE)"         >> $GITIGNOREFILE
    echo "!/$(basename $ENVIRONMENTVARIABLESFILESAMPLE)"  >> $GITIGNOREFILE
    echo "!/$(basename $DOCKERCOMPOSEFILE)"  >> $GITIGNOREFILE
    echo "/.warp/docker/volumes"             >> $GITIGNOREFILE
fi

warp_message "* Directorio .warp $(warp_message_ok [ok])"
warp_message "* Aplicando permisos a subdirectorios .warp/docker/volumes $(warp_message_ok [ok])"

warp_message ""

warp_message_warn "Para iniciar los contenedores: $(warp_message_bold './warp start')"
warp_message_warn "Para más información: $(warp_message_bold './warp help')"
sleep 1
