> https://emby.media/docker-server.html

```shell
docker run -itd --name emby \
    -p 8096:8096 \
    -p 8920:8920 \
    -v ./media:/media \
    emby/embyserver
```

http://127.0.0.1:8096/web/index.html?start=wizard#!/wizard/wizardstart.html
