warp_message ""
warp_message_warn "Configurando archivo $ENVIRONMENTVARIABLESFILESAMPLE como variable de entorno"
sleep 1
cp $ENVIRONMENTVARIABLESFILESAMPLE $ENVIRONMENTVARIABLESFILE
warp_message_ok "Archivo creado $ENVIRONMENTVARIABLESFILE"

warp_message_warn "Preparando archivos para .gitignore"
sleep 1

warp_message_ok "Datos agregados en $GITIGNOREFILE"
sleep 1

# FILES TO ADD GITIGNORE
echo "/.warp"  >> $GITIGNOREFILE
echo "/.env"   >> $GITIGNOREFILE
echo "/dist"   >> $GITIGNOREFILE
echo "/images" >> $GITIGNOREFILE
echo "!/.env.sample" >> $GITIGNOREFILE

warp_message ""

warp_message_warn "Para iniciar los contenedores: $(warp_message_bold 'warp start')"
sleep 2

# View default options
help
