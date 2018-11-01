#!/bin/bash

# INCLUDE WARP FRAMEWORK
. "$WARPFOLDER/lib/version.sh"
. "$WARPFOLDER/lib/commit.sh"
. "$WARPFOLDER/lib/env.sh"
. "$WARPFOLDER/lib/message.sh"
. "$WARPFOLDER/lib/net.sh"
. "$WARPFOLDER/lib/question.sh"
. "$WARPFOLDER/lib/check.sh"
. "$WARPFOLDER/lib/banner.sh"

# INCLUDE COMMANDS
. "$WARPFOLDER/bin/mysql.sh"
. "$WARPFOLDER/bin/start.sh"
. "$WARPFOLDER/bin/stop.sh"
. "$WARPFOLDER/bin/composer.sh"
