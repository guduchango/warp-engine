#!/bin/bash +x

cat $PROJECTPATH/.warp/setup/mac/tpl/docker-compose-warp-mac.yml >> $DOCKERCOMPOSEFILEMAC

VOLUME_WARP_DEFAULT="warp-volume-sync"
VOLUME_WARP="$(basename $(pwd))-volume-sync"

cat $DOCKERCOMPOSEFILEMAC | sed -e "s/$VOLUME_WARP_DEFAULT/$VOLUME_WARP/" > "$DOCKERCOMPOSEFILEMAC.tmp"
mv "$DOCKERCOMPOSEFILEMAC.tmp" $DOCKERCOMPOSEFILEMAC

cat $PROJECTPATH/.warp/setup/mac/tpl/docker-sync.yml >> $DOCKERSYNCMAC

cat $DOCKERSYNCMAC | sed -e "s/$VOLUME_WARP_DEFAULT/$VOLUME_WARP/" > "$DOCKERSYNCMAC.tmp"
mv "$DOCKERSYNCMAC.tmp" $DOCKERSYNCMAC
