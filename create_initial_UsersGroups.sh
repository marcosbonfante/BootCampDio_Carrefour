#!/bin/bash

create_user()
{
  _pass='Senha123'
  _name=$1
  _descrr=$2
  _group=$3
 
  #na versão usada não foi preciso colocar "-crypto" , pois dava erro
  useradd $_name -c "$_descrr" -s /bin/bash -m -p $(openssl passwd $_pass) -G $_group
  passwd $_name -e
}

delete_user()
{
  user_name=$1
  if getent passwd $user_name > /dev/null 2>&1; then
     userdel -rf $user_name
  fi
}

limpar_sistema()
{
  echo "**************  limpando   *********************"

  #diretórios e arquivos
  cd /
  rm -rf publico adm ven sec

  #usuários
  delete_user carlos
  delete_user debora
  delete_user josefina
  delete_user maria
  delete_user sebastiana
  delete_user amanda
  delete_user joao_
  delete_user roberto
  delete_user rogerio

  #grupos
  groupdel -f GRP_ADM
  groupdel -f GRP_VEN
  groupdel -f GRP_SEC

}

criar_ambiente()
{
  echo "**************   criando  **************"
  #diretórios
  cd /

  mkdir publico adm ven sec

  #grupos
  groupadd GRP_ADM
  groupadd GRP_VEN
  groupadd GRP_SEC

  #owner diretório
  chown root:GRP_ADM /adm
  chown root:GRP_VEN /ven
  chown root:GRP_SEC /sec

  #usuários
  create_user carlos "Carlos Barbosa" GRP_ADM
  create_user maria  "Maria da Graça" GRP_ADM
  create_user joao_  "João Carlos" GRP_ADM

  create_user debora "Débora Nascimento" GRP_VEN
  create_user sebastiana "Sebastiana da Silva" GRP_VEN
  create_user roberto "Roberto Carlos" GRP_VEN

  create_user josefina "Josefina Carvalho" GRP_SEC
  create_user amanda "Amanda Luísa" GRP_SEC
  create_user rogerio "Rogério Ceni" GRP_SEC

  #permissões diretórios
  chmod 777 /publico/
  chmod 770 /adm
  chmod 770 /ven
  chmod 770 /sec
}





echo "Iniciando processamento"
limpar_sistema
criar_ambiente
echo "Finalizado com êxito!"
