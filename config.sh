#!/bin/bash

# Atualizando as informações do git
git config --global user.email "gfsilveira@gmail.com"
git config --global user.user "Guilherme F Silveira"

# Instalando o programa tree, para obtenção da estrutura de diretórios e atualizando a estrutura
sudo apt-get update
sudo apt-get install -y tree
tree > directory_structure.txt

# Instalando o Docker, o docker-compose, e subindo o ambiente
curl -fsSL http://get.docker.com | sh
sudo usermod -aG docker ubuntu
sudo apt-get install -y docker-compose
sudo docker-compose -f /home/ubuntu/doc_CNN_Eloiza/docker/docker-compose-app.yml up -d
