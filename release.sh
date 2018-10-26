#!/bin/bash

tar cJf warparchive.tar.xz --exclude=".DS_Store" .warp/.
cat warp > dist/warp
cat warparchive.tar.xz >> dist/warp
chmod +x dist/warp