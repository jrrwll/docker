### deploy
```bash
docker run -it -d --name hbase \
    -p 16010:16010 -p 16030:16030 \
    tukeof/hbase
```

### test on mac osx
```bash
open http://localhost:16010/master-status
open http://localhost:16030/rs-status
```
