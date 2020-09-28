#!/bin/bash
username='YOUR_STEAM_USER'
password='YOUR_STEAM_PASSWORD'
os='YOUR_PREFERRED_OS'
destdir=/YOUR/DESTINATION/DIRECTORY


[ -z "$1" ] && echo "Usage: $(basename $0) <app-id>" && exit 1
targetdir="/steam/$1"
[ ! -d $destdir ] && mkdir -p $destdir
sudo docker run -it -v ${destdir}:/steam depotdownloader:2.3.6 download -app $1 -username ${username} -password ${password} -dir ${targetdir} -os ${os} -remember-password
