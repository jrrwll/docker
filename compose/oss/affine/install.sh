# https://docs.affine.pro/self-host-affine/install/docker-compose-recommend

docker exec -it pgvector psql -U postgres \
  -c "create user affine with password 'affine';"

docker exec -it pgvector psql -U postgres \
  -c "create database affine owner affine;"

docker exec -it pgvector psql -U postgres \
  -c "grant all privileges on database affine to affine;"
