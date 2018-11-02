#!/bin/bash


COMMIT_VERSION=`git rev-parse --short HEAD`
BUILD_VERSION=`tail -n 1 .warp/lib/version.sh | sed "s/WARP_VERSION=//g" | tr -d '"'`
TAG_VERSIONS=`git tag -l | sort -r`


cat release/commit.sh.template | sed -e "s/COMMIT_VERSION/${COMMIT_VERSION}/" > .warp/lib/commit.sh

tar cJf warparchive.tar.xz --exclude=".DS_Store" .warp/.
cat warp > dist/warp
cat warparchive.tar.xz >> dist/warp
chmod +x dist/warp