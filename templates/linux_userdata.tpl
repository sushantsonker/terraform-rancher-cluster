#!/bin/bash
echo ${rancher_message}
yum update -y
yum install -y wget
yum install -y git
cd /home/ec2-user
wget https://get.helm.sh/helm-v2.14.3-linux-amd64.tar.gz
tar -xvzf helm-v2.14.3-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.15.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
cp /usr/local/bin/kubectl /usr/local/sbin
# sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# yum install -y http://mirror.centos.org/centos/7/extras/x86_64/Packages/container-selinux-2.74-1.el7.noarch.rpm
sudo yum-config-manager --enable rhui-REGION-rhel-server-extras
yum install -y docker
service docker start
docker run -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher