#!/bin/bash

set -e

MODE=$1
VERSION=$2
if [[ "$MODE" = "img" ]]; then
    convert ./resources/emoflon-splash_template.png -font Liberation-Sans -pointsize 24 -draw "gravity south fill white text 0,15 '${VERSION}'" splash.bmp
elif [[ "$MODE" = "deploy" ]]; then
    mkdir -p ./eclipse/plugins/org.emoflon.splash

    # check if splash.bmp exists
    if [[ ! -f splash.bmp ]]; then
        echo "=> splash.bmp not found. Exit."; exit 1 ;
    fi

    mv splash.bmp ./eclipse/plugins/org.emoflon.splash
    sed -i 's/org.eclipse.epp.package.common/org.emoflon.splash/g' ./eclipse/eclipse.ini
    sed -i 's/osgi.splashPath=platform\\:\/base\/plugins\/org.eclipse.platform/osgi.splashPath=platform\\:\/base\/plugins\/org.emoflon.splash/g' ./eclipse/configuration/config.ini
fi
