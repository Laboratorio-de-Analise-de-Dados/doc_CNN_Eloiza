# Estrutura básica de ambiente Python com Docker

## Uso do Terminal

### Lista as informações no diretório
~~~sh
ll
~~~

### Verifica o caminho (*path*) local
~~~sh
pwd
~~~

### Entra em uma pasta com nome *nome da pasta*
~~~sh
cd ./<nome da pasta>
~~~

### Retorna a pasta superior
~~~sh
cd ./../
~~~

### Cria uma nova pasta chamada *nome da pasta*
~~~sh
mkdir <nome da pasta>
~~~

### Remove uma pasta
~~~sh
rm -r <nome da pasta>
~~~

### Cria um arquivo chamado *nome do arquivo*
~~~sh
touch <nome do arquivo>
~~~

### Cria um arquivo chamado *nome do arquivo* e escreve a *mensagem* na primeira linha
~~~sh
echo "<mensagem>" > <nome do arquivo>
~~~

### Cria um arquivo chamado *nome do arquivo* e subescreve a *mensagem* na primeira linha
~~~sh
echo "<mensagem>" > <nome do arquivo>
~~~

### Cria um arquivo chamado *nome do arquivo* e adiciona a *mensagem* na próxima linha
~~~sh
echo "<mensagem>" >> <nome do arquivo>
~~~

### Cria uma cópia do arquivo *nome do arquivo*
~~~sh
cp <nome do arquivo> <novo nome do arquivo>
~~~

### Move o arquivo *nome do arquivo*
~~~sh
cp <nome do arquivo> <novo local do arquivo>
~~~

___

## Uso do terminal com SSH

### Conexão *local->servidor*

~~~sh
ssh -i <local da chave> usuario@ip_servidor
~~~

### Enviando comando do *local->servidor*

~~~sh
ssh -i <local da chave> usuario@ip_servidor <comando>
~~~

## Enviar pasta do *local->servidor*

~~~sh
scp -i <local da chave> -r <local com o nome da pasta> usuario@ip_servidor:<local da pasta>
~~~

## Enviar pasta do *servidor->local*

~~~sh
scp -i <local da chave> -r usuario@ip_servidor:<local com o nome da pasta> <local da pasta>
~~~

___

## Estrutura e arquivos

### Criação inicial da estrutura de diretórios e arquivos
~~~sh
mkdir <nome-do-repo>
cd <nome-do-repo>
mkdir docker
mkdir script
touch .gitignore
touch README.md
touch ./docker/docker-compose-app.yml
touch ./docker/python.Dockerfile
touch ./docker/python_req.txt
touch config.sh
sudo chmod 746 ./config.sh
touch estrutura_diretorio.txt
~~~

### Informações do arquivo .gitignore
~~~sh
echo "__pycache__/" >> ./.gitignore
echo ".ipynb_checkpoints/" >> ./.gitignore
echo ".pytest_cache/" >> ./.gitignore
~~~

### Informações do arquivo docker-compose-app.yml
~~~yml
version: "3.7"
services:
    risk_stratification:
        build: 
            dockerfile: ./python.Dockerfile
            context: .
        container_name: risk_stratification
        volumes:
            - ./../script:/usr/src/myapp
        networks:
            - default
        ports:
            - 8888:8888

volumes:
    persistent:
~~~

### Informações do arquivo python.Dockerfile
~~~Dockerfile
FROM python:3.7.9

LABEL maintainer="Guilherme F Silveira"

WORKDIR /usr/src/myapp

COPY ./python_req.txt /usr/src/myapp

RUN pip install --upgrade pip && \
    pip install -r python_req.txt && \
    apt-get update && \
    # Instrução de instalções para exportar o notebook para pdf
    apt-get install -y pandoc && \
    apt-get install -y texlive-xetex texlive-fonts-recommended texlive-plain-generic

COPY . /usr/src/myapp

EXPOSE 8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]
~~~

### Informações do arquivo python_req.txt
~~~txt
Flask==2.1.1
joblib==1.1.0
jupyter==1.0.0
jupyterlab==3.4.3
Keras==2.4.3
matplotlib==3.5.2
numpy==1.19.5
pandas==1.3.5
PyMySQL==1.0.2
pytest==7.1.2
scipy==1.7.3
seaborn==0.11.2
sklearn==0.0
tensorflow==2.4.1
util-gfsilveira==0.1
~~~

### Informações do arquivo config.sh
~~~sh
#!/bin/bash

# Atualizando as informações do git
git config --global user.email "gfsilveira@gmail.com"
git config --global user.user "Guilherme F Silveira"

# Instalando o programa tree, para obtenção da estrutura de diretórios e atualizando a estrutura
sudo apt-get update
sudo apt-get install -y tree
tree > estrutura_diretorio.txt

# Instalando o Docker, o docker-compose, e subindo o ambiente
curl -fsSL http://get.docker.com | sh
sudo apt-get install -y docker-compose
sudo docker-compose -f ./docker/docker-compose-app.yml up
~~~

___

## Git -> comandos básicos

### Uma vez inicia o repositório remoto, vincular a pasta local ao repositório remoto
~~~sh
git init
git add .
git commit -m "First commit"
git branch -M main
git remote add origin https://github.com/Laboratorio-de-Analise-de-Dados/env-docker.git
git push -u origin main
~~~

### Obter as últimas informações do repositório **REALIZAR NO INÍCIO DAS ATIVIDADES**
~~~sh
git pull
~~~

### Adicionar as modificações para serem enviadas (*commitadas*)
~~~sh
git add .
~~~

### Registrando o envio (*commit*) das informações
~~~sh
git commit -m "Mensagem de explicação do motivo das modificações"
~~~

### Enviaando as informações para o repositório remoto
~~~sh
git push -u origin main
~~~

### Obtendo informações sobre os commites
~~~sh
git status
~~~

### Clonar o repositorio do GitHub
~~~sh
git clone https://github.com/Laboratorio-de-Analise-de-Dados/env-docker.git
~~~

### Criar uma nova branch
~~~sh
git checkout -b <branch>
~~~

### Envia a nova brnach para o GitHub
~~~sh
git push --set-upstream origin <branch>
~~~

### Acessa a nova branch
~~~sh
git checkout -b <branch>
git branch --set-upstream-to=origin/<branch> <branch>
git pull
~~~

### Retorna ao último cmomit sem enviar as alterações
~~~sh
git stash
~~~

### Retornando um commit
~~~sh
git revert <id_do_commit>
~~~

### Diferença entre dois commites
~~~sh
git diff <id_do_commit_inic>..<id_do_commit_final>
~~~

### Adicionar uma tag
~~~sh
git tag -a <nome_da_tag> -m "<mensagem>"
~~~

___

## Docker -> comandos básicos

### Subindo o ambiente com o docker-compose
~~~sh
docker-compose -f ./docker/docker-compose-app.yml up
~~~

### Removendo o ambiente com o docker-compose
~~~sh
docker-compose -f ./docker/docker-compose-app.yml down
~~~

### Finalizando conteiner do JupyterLab
~~~sh
Ctrl+c
~~~

### Parar o ambiente
~~~sh
docker stop env-docker
~~~

### Reiniciar o ambiente
~~~sh
docker restart env-docker
~~~

### Iniciando o ambiente
~~~sh
docker start env-docker
~~~

### Resgatar a informação do link de acesso ao JupyterLab
~~~sh
docker logs env-docker
~~~

### Entra no container
~~~sh
docker exec -it env-docker /bin/bash
~~~

### Roda um arquivo python no container chamado *nome do arquivo*
~~~sh
docker exec env-docker python ./<nome do arquivo>
~~~

### Acessando os containers em execussão
~~~sh
docker ps
~~~

### Acessando todos os containers
~~~sh
docker ps -a
~~~

### Acessando as imagens locais
~~~sh
docker images
~~~

### Deletar todas as informações do Docker
~~~diff
- Deletar containers
~~~
~~~sh
docker rm -f $(docker ps -a -q)
~~~
~~~diff
- Deletar imagens
~~~
~~~sh
docker rmi -f $(docker images -q)
~~~
~~~diff
- Deletar volumes
~~~
~~~sh
docker system prune -f -a --volumes
~~~