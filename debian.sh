#!/usr/bin/env bash

# basic
# vim  /etc/sudoers
# %sudo ALL=(ALL) NOPASSWD: ALL
# tuke ALL=(ALL) NOPASSWD: ALL

sudo apt update
# https://mirrors.tuna.tsinghua.edu.cn/help/debian/
sudo apt install apt-transport-https ca-certificates -y
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cat <<EOF > /etc/apt/sources.list
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free
deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free
EOF
sudo apt update

sudo apt install openssh-server -y
sudo systemctl start ssh
sudo systemctl enable ssh

sudo apt install vim zsh git curl wget -y
[ $(which zsh) = '/usr/bin/zsh' ] && sudo chsh -s /usr/bin/zsh

# ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#
cd ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
cd ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-autosuggestions
cp ~/.oh-my-zsh/themes/agnoster.zsh-theme ~/.oh-my-zsh/custom/themes/myagnoster.zsh-theme

# docker
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $(whoami)

cat <<EOF > /etc/docker/daemon.json
{
  "registry-mirrors": [
      "https://docker.mirrors.ustc.edu.cn/"
  ]
}
EOF

while read line; do
  docker pull $line
done <<EOF 
mysql
redis
mongo
cassandra
rabbitmq:3-management
bobbystrange/nexus
elasticsearch:7.10.1
kibana:7.10.1
EOF

# mysql
sudo apt install gnupg -y
# https://dev.mysql.com/downloads/repo/apt/
wget https://dev.mysql.com/get/mysql-apt-config_0.8.16-1_all.deb
sudo dpkg -i mysql-apt-config_0.8.16-1_all.deb
sudo apt update
sudo apt install mysql-server -y
sudo systemctl start mysql
sudo systemctl enable mysql

# postgresql
#sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
#wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
#sudo apt-get update
#sudo apt-get -y install postgresql
sudo apt install postgresql postgresql-client -y
sudo systemctl start postgresql
#sudo -i -u postgres
#psql
