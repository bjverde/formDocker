#!/bin/bash

echo "Baixando FormDin FrameWork em www/formdin";
cd www
git clone https://github.com/bjverde/formDin.git

echo "Baixando SysGen - o sistema gerador de sistemas";
cd formDin
git clone https://github.com/bjverde/sysgen.git
cd ../..

echo "Instalando Docker";

sudo apt-get remove docker docker-engine docker.io;
sudo apt-get update;
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common;
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable";
sudo apt-get update;
sudo apt-get install docker-ce;
sudo docker-compose build;
sudo docker-compose up;