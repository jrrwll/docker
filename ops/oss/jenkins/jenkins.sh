

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

# vim /etc/apt/sources.list
# deb https://pkg.jenkins.io/debian binary/

sudo apt update
sudo apt install jenkins -y

sudo find / -name "jenkins"
# sudo vim /etc/default/jenkins
# HTTP_PORT=60030
sudo systemctl start jenkins

# sudo cat /var/lib/jenkins/secrets/initialAdminPassword
