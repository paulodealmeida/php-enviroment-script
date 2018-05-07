#!/bin/sh

#######################################################
#######################################################
## Script para configuração de Ambiente Ubuntu 18.04 ##
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
    fancy_echo "Ops, não é possível utilizar esse script para SO diferentes do Ubuntu 18.";
    exit 0;
  fi

  if [ "${MASTERVERSION}" != "18" ]; then
    fancy_echo "Ops, não é possível utilizar esse script para SO diferentes do Ubuntu 18";
    exit 0;
  fi
}

fancy_echo "Verificando sistema ..."
  check_sistem

fancy_echo "Atualizando sistema ..."
  sudo apt update

fancy_echo "Instalando Sublime Text ..."
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  sudo apt install -y apt-transport-https
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  sudo apt update
  sudo apt install -y sublime-text

fancy_echo "Instalando git ..."
  sudo apt-get install -y git

fancy_echo "Instalando curl ..."
  sudo apt-get install -y curl

fancy_echo "Instalando docker ..."
  # Remove versões antigas
  sudo apt-get remove docker docker-engine docker.io
  # Instalação
  sudo apt-get update
  sudo apt-get install -y ca-certificates software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get update
  sudo apt-get install -y docker.io
  
fancy_echo "Instalando docker-compose..."
  COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1`
  sudo curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

fancy_echo "Instalando aplicativos comuns ..."
  sudo apt-get install -y unrar unzip vim

# fancy_echo "Instalando Spotify ..."
#   sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
#   echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
#   sudo apt-get update
#   sudo apt-get install -y spotify-client

fancy_echo "Instalando Oracle JDK 9 ..."
  sudo apt-get install -y default-jre
  sudo apt-get install -y default-jdk
  # sudo add-apt-repository ppa:webupd8team/java
  sudo apt-get update
  # sudo apt-get install -y oracle-java9-installer
  # sudo echo 'export JAVA_HOME="/usr/lib/jvm/java-9-oracle"' >> ~/.bashrc

# fancy_echo "Instalando Apache2, PHP7.0, MySQL 5.7 e libs necessárias do PHP7.0 e Apache2 ..."
#   sudo apt-get install -y apache2
#   sudo apache2ctl configtest
#   sudo apt-get install -y mysql-server
#   sudo apt-get install -y php7.0 php7.0-mbstring php7.0-mcrypt php7.0-dev php7.0-gd php7.0-json php7.0-mysql php7.0-opcache php7.0-xml php7.0-xmlrpc libapache2-mod-php7.0
#   sudo phpenmod mcrypt
#   sudo phpenmod mbstring

# fancy_echo "Instalando PHPUnit Latest ..."
#   wget https://phar.phpunit.de/phpunit.phar -O /tmp/phpunit.phar
#   chmod +x /tmp/phpunit.phar
#   sudo mv /tmp/phpunit.phar /usr/local/bin/phpunit

# fancy_echo "Instalando Composer Latest ..."
#   curl -sS https://getcomposer.org/installer | php
#   sudo mv composer.phar /usr/local/bin/composer

fancy_echo "Instalando Workbench (Versão final do Repositório padrão) ..."
  sudo apt-get install -y mysql-workbench

# fancy_echo "Baixando Netbeans 8.2 ..."
#   wget http://download.netbeans.org/netbeans/8.2/final/bundles/netbeans-8.2-php-linux-x64.sh -O /tmp/netbeans-8.2-php-linux-x64
#   sudo chmod +x /tmp/netbeans-8.2-php-linux-x64
# fancy_echo "Instalando Netbeans  8.2 ..."
#   sudo bash /tmp/netbeans-8.2-php-linux-x64 --silent
#   sudo rm -rf /tmp/*

# fancy_echo "Instalando Rocketeer Latest ..."
#   wget http://rocketeer.autopergamene.eu/versions/rocketeer.phar
#   sudo chmod +x ./rocketeer.phar
#   sudo mv ./rocketeer.phar /usr/local/bin/rocketeer

# fancy_echo "Instalando API Doc ..."
#   sudo apt-get install -y nodejs-legacy
#   sudo apt-get install -y npm
#   sudo npm install apidoc -g
  
# fancy_echo "Habilitando o mod_rewrite ..."
#   sudo a2enmod rewrite
#   sudo service apache2 restart

fancy_echo "Atualizando sistema ..."
  sudo apt-get update
  sudo apt-get upgrade

fancy_echo "Limpando a instalação com pacotes não utilizados ..."
  sudo apt-get autoclean
  sudo apt-get clean
  sudo apt-get autoremove