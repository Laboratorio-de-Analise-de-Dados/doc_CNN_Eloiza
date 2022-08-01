#!/bin/bash

tree > estrutura_diretorio.txt

git add .
git commit -m "$1"
git push origin $2
