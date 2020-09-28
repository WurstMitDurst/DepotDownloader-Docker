## Depot Downloader

The DepotDownloader let's you download applications and workshop items from your Steam account.
Please visit https://github.com/SteamRE/DepotDownloader for more information.

## Manual usage

```
docker run -it -v <DESTINATION_DIR>:/steam -v <DEPOT_DOWNLOADER_SHARE>:/root/.local/share depotdownloader:<tag> download -app <app_id>
```

- `-it` is necessary to activate docker's interactive mode, as the DepotDownloader expects you to type in username, password and two-factor authentication tokens (if enabled). If you forget this argument, you might get an authentication loop, which will result in an excess of Steams rate limit. In that case, you might have to wait 30 minutes, before Steam allows a Login from your network.
- `<DEPOT_DOWNLOADER_SHARE>` must be a path to a local folder or a docker volume. This directory is used by the DepotDownloader to store login credentials and authentication tokens (if needed).
- `download` will invoke the actual DepotDownloader. Please refer to the official DepotDownloader documentation for the argument descriptions.

## Usage with bash script

For easy invocation, you might want to use the following bash script:

```
#!/bin/bash
appversion='2.3.6'
username='YOUR_STEAM_USER'
password='YOUR_STEAM_PASSWORD'
os='YOUR_PREFERRED_OS'
destdir=/YOUR/DESTINATION/DIRECTORY

volumeinspection=$((sudo docker volume inspect DepotDownloaderShare) 2>&1)
if [[ $volumeinspection == *"No such volume"* ]]; then
  sudo docker volume create DepotDownloaderShare
fi

[ -z "$1" ] && echo "Usage: $(basename $0) <app-id>" && exit 1
targetdir="/steam/$1"
[ ! -d $destdir ] && mkdir -p $destdir
sudo docker run -it --rm --name DepotDownloader -v ${destdir}:/steam -v DepotDownloaderShare:/root/.local/share depotdownloader:${appversion} download -app $1 -username ${username} -password ${password} -dir ${targetdir} -os ${os} -remember-password
```
