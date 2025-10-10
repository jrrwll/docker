
mysql -h 127.0.0.1 -P 4000 -u root

docker run -it --rm pingcap/dumpling \
  -h 127.0.0.1 -P 4000 -u root \
  -o /backup/data --filetype sql

