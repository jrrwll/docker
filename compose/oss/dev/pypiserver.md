## run directly

**start server**

```shell
pyenv virtualenv 3.12 pypiserver
pyenv activate pypiserver

pip install pypiserver passlib setuptools wheel twine

mkdir pypiserver && cd pypiserver
mkdir ./packages
mkdir ./packages

htpasswd -bcm .pypiserver-htpasswd tuke tuke
pypi-server run --host 0.0.0.0 --port 8080 -P ./.pypiserver-htpasswd ./packages
```

**config client**

```shell
cat <<EOF > ~/.pypirc
[distutils]
index-servers=pypiserver

[pypiserver]
# repository = https://nexus_addr/repository/pypi-hosted/
repository: http://127.0.0.1:8080/
username: tuke
password: tuke
EOF
```

**publish packages**

```shell
cat <<EOF > pyproject.toml
[build-system]
requires = ["setuptools>=61.0", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "demo"
version = "0.1"
dependencies = [
"requests>=2.24.0",
]
EOF

pip install build twine
python -m build

# local develop
pip install -e .

# upload
twine upload -r pypiserver dist/*

# install
pip install -i http://127.0.0.1:8080/simple/ --trusted-host 127.0.0.1
```

## docker
> https://hub.docker.com/r/pypiserver/pypiserver

```shell
docker run -itd --name pypiserver \
    -p 8080:8080
    -v /root/pypi/packages:${PWD}/packages \
    pypiserver/pypiserver -P . -a . ./packages
```

**with auth**

```shell
htpasswd -bcm .pypiserver-htpasswd tuke tuke

docker run -itd --name pypiserver \
    -p 8080:8080 \
    -v ${PWD}/.pypiserver-htpasswd:/data/.pypiserver-htpasswd \
    -v ${PWD}/packages:/data/packages \
    pypiserver/pypiserver run --host 0.0.0.0 -P .pypiserver-htpasswd ./packages
```

**pypiserver.dev.dreamcat.org.conf**

```nginx configuration
server {
    listen       80;
    server_name  pypiserver.dev.dreamcat.org;

    location / {
        proxy_pass http://$LOCAL_IP:8080;
        
        # welcome.html need it to render the `{{URL}}` variable
        proxy_set_header   Host              $host;
        proxy_set_header   X-Real-IP         $remote_addr;
        proxy_set_header   X-Forwarded-For   $proxy_add_x_forwarded_for;
    }

    location /health {
        add_header Content-Type "text/plain;charset=utf-8";
        return 200 "Your IP Address:$remote_addr";
    }
}
```
