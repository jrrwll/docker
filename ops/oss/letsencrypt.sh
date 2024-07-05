#!/usr/bin/env bash

# apt install nginx
# systemctl enable nginx
# cd /etc/nginx/sites-enabled

# nginx
# ssl_certificate	cert.pem
# ssl_certificate_key	privkey.pem

apt install certbot -y

systemctl stop nginx
certbot certonly --standalone -m bobby.j.strange@gmail.com -d gitlab.singlar.org
certbot certonly --standalone -m bobby.j.strange@gmail.com -d sonarqube.singlar.org
certbot certonly --standalone -m bobby.j.strange@gmail.com -d jenkins.singlar.org

echo '0 3 * */1 * certbot renew --pre-hook "systemctl stop nginx" --post-hook "systemctl start nginx"' | crontab -
