## Depot Downloader

The DepotDownloader let's you download applications and workshop items from your Steam account.
Please visit https://github.com/SteamRE/DepotDownloader for more information.

## Manual usage

```
docker run -it -v <DESTINATION_DIR>:/steam depotdownloader:<tag> download -app <app_id>
```

- `-it` is necessary to activate docker's interactive mode, as the DepotDownloader expects you to type in username, password and two-factor authentication tokens (if enabled). If you forget this argument, you might get an authentication loop, which will result in an excess of Steams rate limit. In that case, you might have to wait 30 minutes, before Steam allows a Login from your network.
- `download` will invoke the actual DepotDownloader. Please refer to the official DepotDownloader documentation for the argument descriptions.

## Usage with bash script

For easy invocation, you might want to use the following bash script:

```
#!/bin/bash
username='YOUR_STEAM_USER'
password='YOUR_STEAM_PASSWORD'
os='YOUR_PREFERRED_OS'
destdir=/YOUR/DESTINATION/DIRECTORY

[ -z "$1" ] && echo "Usage: $(basename $0) <app-id>" && exit 1
targetdir="/steam/$1"
[ ! -d $destdir ] && mkdir -p $destdir
sudo docker run -it -v ${destdir}:/steam depotdownloader:2.3.6 download -app $1 -username ${username} -password ${password} -dir ${targetdir} -os ${os} -remember-password
```
