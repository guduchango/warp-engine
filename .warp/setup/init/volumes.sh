cat $PROJECTPATH/.warp/setup/init/tpl/appdata.yml >> $PROJECTPATH/docker-compose.yml

cp -R ./.warp/setup/init/config/appdata ./.warp/docker/config/appdata