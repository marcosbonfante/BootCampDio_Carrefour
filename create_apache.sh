#!/bin/bash
 
echo 'Atualizando sistema..;.'
 apt-get update  -y
 apt-get upgrade -y

echo 'Instalando pacotes';
 apt-get install unzip -y
 apt-get install apache2 -y
 apt-get install wget -y
 systemctl enable apache2
 
echo 'baixando e descompactando app...';
 cd  /tmp
 wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip
 unzip main.zip -d app

echo 'Copiando arquivos...'
 rm -rf /var/www/html/*
 cp -rf /tmp/app/linux-site-dio-main/* /var/www/html

echo 'limpando lixo...'
 rm -f /tmp/main.zip
 rm -rf /tmp/app
 
echo 'Finalizado !!'
