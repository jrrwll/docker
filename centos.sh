#!/usr/bin/env bash

# basic
sudo yum install yum-fastestmirror
sudo yum install git wget curl -y

# ohmyzsh
sudo yum install -y zsh git
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cd ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
cd ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-autosuggestions

# docker
sudo yum install dnf-plugins-core -y
sudo yum install docker -y
sudo systemctl start docker
#sudo groupadd docker
#sudo usermod -aG docker $(whoami)
sudo systemctl enable docker
sudo systemctl start docker

# mysql
sudo yum install community-mysql
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum update -y
sudo yum install mysql-server
sudo systemctl start mysqld

# mongodb
cat <<EOF | sudo tee /etc/yum.repos.d/mongodb-org-4.0.repo
[mongodb-org-4.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc
EOF
sudo dnf install mongodb-org-shell mongodb-org-tools
