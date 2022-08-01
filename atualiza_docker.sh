#!/bin/bash

sudo docker rm -f $(sudo docker ps -a -q)
sudo docker rmi -f $(sudo docker images -q)
sudo docker system prune -f -a --volumes

sudo docker-compose -f ./docker/docker-compose-app.yml up