cat $PROJECTPATH/.warp/setup/init/tpl/appdata.yml >> $DOCKERCOMPOSEFILE

cp -R ./.warp/setup/init/config/appdata ./.warp/docker/config/appdata