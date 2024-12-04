> https://jellyfin.org/docs/general/installation/container/
> https://repo.jellyfin.org/files/client/android/
> 
```shell
# -v ./config:/config
# -v ./fonts:/usr/local/share/fonts/custom:ro
docker run -itd --name jellyfin \
 -p 8096:8096 \
 --mount type=bind,source=./media,target=/media \
 --restart=unless-stopped \
 jellyfin/jellyfin
```

http://127.0.0.1:8096/web/index.html#/wizardstart.html

