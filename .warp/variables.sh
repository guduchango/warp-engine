#!/bin/sh
#

# PROJECTPATH contains the full
# directory path of the project itself
PROJECTPATH=$(pwd)

# CONFIGFOLDER contains the path
# to the config folder.
CONFIGFOLDER="$PROJECTPATH/.warp/docker/config"

# SSLCERTIFICATEFOLDER contains the path
# to the SSL certificate folder that is used by Nginx.
SSLCERTIFICATEFOLDER="$CONFIGFOLDER/nginx/ssl"

# ENVIRONMENTVARIABLESFILE contains the path
# to the file that holds the required environment
# variables for this script.
ENVIRONMENTVARIABLESFILESAMPLE="$PROJECTPATH/.env.sample"

# ENVIRONMENTVARIABLESFILE contains the path
# to the file that holds the required environment
# variables for this script.
ENVIRONMENTVARIABLESFILE="$PROJECTPATH/.env"

# DOCKERCOMPOSEFILE contains the path
# to the docker-compose.yml sample file
DOCKERCOMPOSEFILESAMPLE="$PROJECTPATH/docker-compose-warp.yml.sample"

# DOCKERCOMPOSEFILE contains the path
# to the docker-compose.yml file
DOCKERCOMPOSEFILE="$PROJECTPATH/docker-compose-warp.yml"

# PROJECTPATH FRAMEWORK
WARPFOLDER="$PROJECTPATH/.warp"

# FILE TO GIT IGNORE
GITIGNOREFILE="$PROJECTPATH/.gitignore"

# NETWORK NAME
NETWORK_NAME="warp_net"

# Set minimum range IP in Containers
MIN_RANGE_IP=20

# SET PATH TO BINARY WARP
WARP_BINARY_FILE="/usr/local/bin/warp"
