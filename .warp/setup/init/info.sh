warp_message "* Configurando archivos de variables de entorno $(warp_message_ok [ok])"
cp $ENVIRONMENTVARIABLESFILESAMPLE $ENVIRONMENTVARIABLESFILE

warp_message "* Preparando archivos para .gitignore $(warp_message_ok [ok])"
# FILES TO ADD GITIGNORE
echo "# WARN FRAMEWORK"  >> $GITIGNOREFILE
echo "!/warp"            >> $GITIGNOREFILE
echo "!/.warp"           >> $GITIGNOREFILE
echo "/.env"             >> $GITIGNOREFILE
echo "!/.env.sample"     >> $GITIGNOREFILE
echo "!/docker-compose-warn.yml" >> $GITIGNOREFILE
echo "/.warp/docker/volumes"     >> $GITIGNOREFILE

warp_message "* Directorio .warp $(warp_message_ok [ok])"
warp_message "* Aplicando permisos a subdirectorios .warp/docker/volumes $(warp_message_ok [ok])"

warp_message ""

warp_message_warn "Para iniciar los contenedores: $(warp_message_bold 'warp start')"
warp_message_warn "Para más información: $(warp_message_bold 'warp help')"
sleep 1
