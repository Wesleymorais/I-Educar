#!/bin/bash
sudo apt-get update && sudo apt-get dist-upgrade -y
sudo apt-get install curl php-curl git-core apache2 libapache2-mod-php php-pgsql php-pear rpl -y
sudo apt-get install postgresql postgresql-client -y
cd ~/Downloads
wget https://s3-us-west-2.amazonaws.com/portabilis2/public/ieducar/ieducar.backup.gz (https://s3-us-west-2.amazonaws.com/portabilis2/p
/ieducar.backup.gz)
gunzip ieducar.backup.gz
sudo su
su postgres
createdb ieducar
pg_restore -d ieducar ieducar.backup
psql -d ieducar -c 'ALTER DATABASE ieducar SET search_path = "$user", public, portal, cadastro, acesso, alimentos, consistenciacao, his
pmicontrolesis, pmidrh, pmieducar, pmiotopic, urbano, modules;'
psql -d ieducar -c "ALTER ROLE postgres WITH PASSWORD '123';"
exit
exit
sudo chmod 777 -R /var/www/html
git -c http.sslVerify=false clone http://softwarepublico.gov.br/gitlab/i-educar/i-educar.git (http://softwarepublico.gov.br/gitlab/i-educar/i-educa
/html/i-educar/
bash /var/www/html/i-educar/ieducar/scripts/install_pear_packages.sh
export CORE_EXT_CONFIGURATION_ENV=development >> sudo nano /etc/apache2/envvars
export APACHE_LOG_DIR=/var/log/apache2$SUFFIX >> sudo nano /etc/apache2/envvars
echo <VirtualHost *:80> >>sudo nano /etc/apache2/sites-available/ieducar.conf
echo ServerName ieducar.local >>sudo nano /etc/apache2/sites-available/ieducar.conf
echo DocumentRoot /var/www/html/i-educar/ieducar >>sudo nano /etc/apache2/sites-available/ieducar.conf
echo <Directory /var/www/html/i-educar/ieducar> >>sudo nano /etc/apache2/sites-available/ieducar.conf
echo Order deny,allow >>sudo nano /etc/apache2/sites-available/ieducar.conf
echo AllowOverride all >> sudo nano /etc/apache2/sites-available/ieducar.conf
echo </Directory> >>sudo nano /etc/apache2/sites-available/ieducar.conf
echo ErrorLog ${APACHE_LOG_DIR}/error.log >>sudo nano /etc/apache2/sites-available/ieducar.conf
echo CustomLog ${APACHE_LOG_DIR}/access.log combined> >>sudo nano /etc/apache2/sites-available/ieducar.conf
echo </VirtualHost> >>sudo nano /etc/apache2/sites-available/ieducar.conf
sudo a2dissite 000-default.conf
sudo a2ensite ieducar.conf
echo "127.0.0.1 ieducar.local" | sudo tee -a /etc/hosts
sudo service apache2 restart
cd /var/www/html/i-educar/
vendor/bin/phinx migrate
