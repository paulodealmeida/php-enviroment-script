#!/bin/sh

fancy_echo() {
  printf "\n%b\n" "$1\n"
}

fancy_echo "Instalando git ..."
  sudo apt-get install -y git

fancy_echo "Instalando curl ..."
  sudo apt-get install -y curl

fancy_echo "Instalando OpenJDK ..."
  sudo apt-get install -y openjdk-7-jdk openjdk-7-jre

fancy_echo "Instalando Apache, Php, MySQL e outros pacotes auxiliares ..."
  # Instalando o Apache
  sudo apt-get -y install apache2
  # Instalando o PHP
  sudo apt-get -y install php5 libapache2-mod-php5 php5-mcrypt php5-curl php5-mysql php5-gd php5-cli php5-dev mcrypt libmysqlclient18
  # Ativando o mcrypt
  sudo php5enmod mcrypt
  sudo apt-get -y install mysql-server mysql-client

fancy_echo "Instalando PHPUnit globalmente ..."
  wget https://phar.phpunit.de/phpunit.phar -O /tmp/phpunit.phar
  chmod +x /tmp/phpunit.phar
  sudo mv /tmp/phpunit.phar /usr/local/bin/phpunit

fancy_echo "Instalando Composer globalmente ..."
  curl -sS https://getcomposer.org/installer | php
  sudo mv composer.phar /usr/local/bin/composer

fancy_echo "Instalando Workbench ..."
  sudo apt-get install -y mysql-workbench

fancy_echo "Baixando Netbeans ..."
  wget http://dlc-cdn.sun.com/netbeans/8.0.2/final/bundles/netbeans-8.0.2-php-linux.sh -O /tmp/netbeans-8.0.2-php-linux.sh
  sudo chmod +x /tmp/netbeans-8.0.2-php-linux.sh
fancy_echo "Instalando Netbeans ..."
  sudo bash /tmp/netbeans-8.0.2-php-linux.sh --silent
  sudo rm -rf /tmp/*

fancy_echo "Instalando Rocketeer ..."
  wget http://rocketeer.autopergamene.eu/versions/rocketeer.phar -o /tmp/rocketeer.phar
  sudo chmod +x /tmp/rocketeer.phar
  sudo mv /tmp/rocketeer.phar /usr/local/bin/rocketeer

fancy_echo "Instalando pacotes auxiliares ..."
  sudo apt-get install -y unrar unzip skype

fancy_echo "Reiniciando Apache ..."
  sudo service apache2 restart

fancy_echo "Atualizando sistema ..."
  sudo apt-get update

fancy_echo "Limpando a instalação com pacotes não utilizados ..."
  sudo apt-get autoclean
  sudo apt-get clean
  sudo apt-get autoremove
