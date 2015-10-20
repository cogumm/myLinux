#!/bin/bash

#---------------------------------------------------------------
# Desenvolvido por Gabriel F. Vilar
# E-mail cogumm@gmail.com
# Website www.cogumm.net
# NÃO ME RESPONSABILIZO POR MAUS DANOS À MÁQUINA COM ESTE SCRIPT, FAVOR UTILIZÁ-LO SE APENAS TIVER CERTEZA DO QUE ESTEJA FAZENDO.
# LOG:
#   19-10-15 => CoGUMm  - Programas de para desenvolvimento
#---------------------------------------------------------------

# script variables
#---------------------------------------------------------------
mainTitle="Meu Ubuntu"
tmpFile=`tempfile`

#---------------------------------------------------------------
# Atualizando o sistema antes da instalação dos programas
installServerUpdates()
{
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get dist-upgrade

    return
}

# VIM
installVim()
{
    sudo apt-get install -y vim

    return
}
# Instalando Apache
installApache()
{
    sudo apt-get install -y apache2

    return
}

# Instalando MySQL
installMySQL()
{
    sudo apt-get install -y mysql-server-5.6

    echo ""
    echo "Type your MySQL root password:"
    echo "\
        CREATE DATABASE \`${username}\` CHARACTER SET utf8; \
        USE \`${username}_production\`; \
        GRANT ALL PRIVILEGES ON \`${username}\`.* TO '$username'@'localhost' IDENTIFIED BY '$mysql_password'; \
        FLUSH PRIVILEGES;" | mysql -u root -p

    sudo /etc/init.d/mysql restart

    cd /var/
    sudo chmod -R 777 www/
    cd www/
    echo "<?php phpinfo() ?>"  >> info.php

    return
}

# Instalando PHP5
installPHP()
{
    sudo apt-get install -y php5 php5-cli php5-curl php5-mysql php5-pgsql php5-sqlite

    return
}

# Instalando phpMyAdmin
installphpMyAdmin()
{
    sudo apt-get install -y phpmyadmin

    sudo /etc/init.d/apache2 restart

    return
}

# Instalando Git
installGit()
{
    sudo apt-get install -y git-core git-gui git-doc gitg

    return
}

# GEdit
installGedit()
{
    sudo apt-add-repository ppa:ubuntu-on-rails/ppa
    sudo apt-get update
    sudo apt-get install -y gedit-gmate

    return
}

# PostgreSQL
installPG()
{
    sudo apt-get install -y postgresql
    sudo apt-get install -y pgadmin3

    sudo su postgres -c psql postgres

    echo ""
    echo "Type your PG root password:"
    echo "\
        ALTER USER postgres WITH PASSWORD 'root'; \
        \q;"

    sudo /etc/init.d/postgresql restart

    return
}

# MySQL-Workbench
installMySQLWorkbench()
{
    cd ~
    if [ -e temp ]
    then
        echo "Diretório já existe."
        cd ~/temp/
    else
        mkdir temp
        cd ~/temp/
    fi
    wget http://dl.dropbox.com/u/1774817/myUbuntu/mysql-workbench-gpl-5.2.33b-1ubu1010-i386.deb
    sudo dpkg -i mysql-workbench-gpl-5.2.33b-1ubu1010-i386.deb

    return
}

# RVM
installRuby()
{
     curl -L https://get.rvm.io | bash -s stable --rails --autolibs=enabled
     rvm install 1.9.3
     rvm use --default 1.9.3

     return
}

# RoR
installRails()
{
    gem install rails
    gem install mysql2

    return
}

# Sublime Text 2
installSublime()
{
    sudo add-apt-repository ppa:webupd8team/sublime-text-2
    sudo apt-get update
    sudo apt-get install sublime-text-2-dev

    return
}

# Atom
installAtom()
{
    cd ~
    if [ -e temp ]
    then
        echo "Diretório já existe."
        cd ~/temp/
    else
        mkdir temp
        cd ~/temp/
    fi
    wget https://github-cloud.s3.amazonaws.com/releases/3228505/873ec70a-6378-11e5-96e0-a5349100d0aa.deb?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIMWPLRQEC4XCWWPA%2F20151015%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20151015T031937Z&X-Amz-Expires=3600&X-Amz-Signature=c4e01c7e6973f8868453388dadb8613cefdb07c0136ca74623f038693f444961&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Datom-amd64.deb&response-content-type=application%2Foctet-stream
    sudo dpkg -i atom-amd64.deb

    return
}

# Eclipse
installEclipse()
{
    cd ~
    if [ -e temp ]
    then
        echo "Diretório já existe."
        cd ~/temp/
    else
        mkdir temp
        cd ~/temp/
    fi
    wget http://dl.dropbox.com/u/1774817/myUbuntu/eclipse-php-helios-SR2-linux-gtk.tar.gz
    tar -zxvf eclipse-php-helios-SR2-linux-gtk.tar.gz
    sudo mv eclipse /opt/

    return
}


# Should remove tmp file and clear the screen before exiting
exitScript()
{
    clear
    exit 0
}

# Get return and if is esc or cancel, exit
exitIfCancelOrESC()
{
    action=$1

    case $action in
        1) exitScript;;
        255) exitScript;;
        *) return;;
    esac
}

# Removendo o Lixo
# Removendo tudo
installClean()
{
    sudo apt-get -f install
    sudo apt-get autoclean
    sudo apt-get autoremove
    cd ~/
    sudo rm -rf ~/LibreOffice/
    sudo rm -rf ~/temp/
}

# Instalando o dialog
#---------------------------------------------------------------
sudo apt-get install dialog

# Tela de bem vindo
#---------------------------------------------------------------
dialog --backtitle "$mainTitle" --title "Bem vindo!" \
       --yesno "Olá, este é um script para a instalação de alguns pacotes para o Ubuntu.\n\nVocê tem certeza que deseja continuar?" \
       13 50 2> $tmpFile

input=$?
exitIfCancelOrESC $input
clear

#---------------------------------------------------------------
dialog  --backtitle "$mainTitle" --title "Conta de usuário" \
        --inputbox "Um usuário será criado para armazenar todos os arquivos de configuração e sua aplicação.\n\nDigite o nome de usuário abaixo." \
        12 50 app_test 2> $tmpFile

input=$?
exitIfCancelOrESC $input
username=`cat $tmpFile`
clear

# MySQL senha
#---------------------------------------------------------------
dialog  --backtitle "$mainTitle" --title "Conta de usuário do MySQL" \
        --inputbox "Um usuário será adicionado ao MySQL '$username'. Além disso, um banco de dados chamado '${username}' também será criado.\n\nPor favor, digite uma nova senha. para este usuário MySQL." \
        13 50 2> $tmpFile

input=$?
exitIfCancelOrESC $input
mysql_password=`cat $tmpFile`
clear

# Start the process
#---------------------------------------------------------------
installServerUpdates
installVim
installApache
installMySQL
installPHP
installphpMyAdmin
installGit
installGedit
installPG
installMySQLWorkbench
installRuby
installRails
#installSublime
installAtom
#installEclipse
installClean

exitScript
exitIfCancelOrESC


dialog  --backtitle "$mainTitle" --title "Instalação completa!" \
        --msgbox "Para testar o Apache+PHP acesse http://$domain/info.php e veja se esta tudo ok." 8 50

clear
exit 0
