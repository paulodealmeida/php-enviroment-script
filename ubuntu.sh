#!/bin/sh

#######################################################
#######################################################
## Script para configuração de Ambiente Ubuntu 16.04 ##
##                                                   ##
##              Author Paulo de Almeida              ##
##              paulodealmeida@gmail.com             ##
#######################################################
#######################################################

fancy_echo() {
  printf "\n%b\n" "$1\n"
  sleep 1
}

check_sistem(){
  SO=$(sudo cat /etc/issue | tr -s [:space:] | cut -d ' ' -f 1)
  VERSION=$(sudo cat /etc/issue | tr -s [:space:] | cut -d ' ' -f 2)
  MASTERVERSION=$(echo ${VERSION} | cut -d '.' -f 1)

  if [ "${SO}" != "Ubuntu" ]; then
    fancy_echo "Ops, não é possível utilizar esse script para SO diferentes do Ubuntu 16";
    exit 0;
  fi

  if [ "${MASTERVERSION}" != "16" ]; then
    fancy_echo "Ops, não é possível utilizar esse script para SO diferentes do Ubuntu 16";
    exit 0;
  fi
}

fancy_echo "Verificando sistema ..."
  check_sistem

fancy_echo "Atualizando sistema ..."
  sudo apt-get update

fancy_echo "Instalando Sublime Text ..."
  wget https://download.sublimetext.com/sublime-text_build-3126_amd64.deb -O /tmp/sublime.deb
  sudo dpkg -i /tmp/sublime.deb

fancy_echo "Instalando git ..."
  sudo apt-get install -y git

fancy_echo "Instalando curl ..."
  sudo apt-get install -y curl

fancy_echo "Instalando Oracle JDK 8 ..."
  sudo apt-get install -y default-jre
  sudo apt-get install -y default-jdk
  sudo add-apt-repository ppa:webupd8team/java
  sudo apt-get update
  sudo apt-get install -y oracle-java8-installer
  sudo echo 'export JAVA_HOME="/usr/lib/jvm/java-8-oracle"' >> ~/.bashrc

fancy_echo "Instalando Apache2, PHP7.0, MySQL 5.7 e libs necessárias do PHP7.0 e Apache2 ..."
  sudo apt-get install -y apache2
  sudo apache2ctl configtest
  sudo apt-get install -y mysql-server
  sudo apt-get install -y php7.0 php7.0-mbstring php7.0-mcrypt php7.0-dev php7.0-gd php7.0-json php7.0-mysql php7.0-opcache php7.0-xml php7.0-xmlrpc libapache2-mod-php7.0
  sudo phpenmod mcrypt
  sudo phpenmod mbstring

fancy_echo "Instalando PHPUnit Latest ..."
  wget https://phar.phpunit.de/phpunit.phar -O /tmp/phpunit.phar
  chmod +x /tmp/phpunit.phar
  sudo mv /tmp/phpunit.phar /usr/local/bin/phpunit

fancy_echo "Instalando Composer Latest ..."
  curl -sS https://getcomposer.org/installer | php
  sudo mv composer.phar /usr/local/bin/composer

fancy_echo "Instalando Workbench (Versão final do Repositório padrão) ..."
  sudo apt-get install -y mysql-workbench

fancy_echo "Baixando Netbeans 8.2 ..."
  wget http://download.netbeans.org/netbeans/8.2/final/bundles/netbeans-8.2-php-linux-x64.sh -O /tmp/netbeans-8.2-php-linux-x64
  sudo chmod +x /tmp/netbeans-8.2-php-linux-x64
fancy_echo "Instalando Netbeans  8.2 ..."
  sudo bash /tmp/netbeans-8.2-php-linux-x64 --silent
  sudo rm -rf /tmp/*

fancy_echo "Instalando Rocketeer Latest ..."
  wget http://rocketeer.autopergamene.eu/versions/rocketeer.phar
  sudo chmod +x ./rocketeer.phar
  sudo mv ./rocketeer.phar /usr/local/bin/rocketeer

fancy_echo "Instalando aplicativos comuns ..."
  sudo apt-get install -y unrar unzip vim

fancy_echo "Instalando API Doc ..."
  sudo apt-get install -y nodejs-legacy
  sudo apt-get install -y npm
  sudo npm install apidoc -g
  
fancy_echo "Habilitando o mod_rewrite ..."
  sudo a2enmod rewrite
  sudo service apache2 restart

fancy_echo "Atualizando sistema ..."
  sudo apt-get update
  sudo apt-get upgrade

fancy_echo "Limpando a instalação com pacotes não utilizados ..."
  sudo apt-get autoclean
  sudo apt-get clean
  sudo apt-get autoremove
