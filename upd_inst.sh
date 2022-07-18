#!/usr/bin/env bash

echo -en '\033[1;33mНачинается процесс обновления системы \033[0m \n'
        sudo apt update && apt full-upgrade -y
echo -en '\033[1;33mНачинается очистка системы \033[0m \n'
        sudo apt autoremove -y && apt autoclean -y
echo -en '\033[1;33mСистема обновлена \033[0m \n'
echo -en '\033[1;33mНачинается установка Apache2..\033[0m \n'
        sudo apt install apache2 apache2-utils
        sudo systemctl enable apache2
        sudo systemctl start apache2
echo -en '\033[1;33mНачинается установка Mysql.. \033[0m \n'
        sudo apt install mysql-client mysql-server
echo -en '\033[1;33mНачинается установка Php7.4.. \033[0m \n'
        sudo apt install php7.4 php7.4-mysql libapache2-mod-php7.4 php7.4-cli php7.4-cgi php7.4-gd
        sudo a2enmod rewrite
        sudo systemctl restart apache2
echo -en '\033[1;33mНачинается скачивание Wordpress.. \033[0m \n'
        wget -c http://wordpress.org/latest.tar.gz
echo -en '\033[1;33mНачинается разархивирование Wordpress и установка его в /var/www/html... \033[0m \n'
        tar -xzvf latest.tar.gz
        sudo rsync -av wordpress/* /var/www/html/
        sudo chown -R www-data:www-data /var/www/html/
        sudo chmod -R 755 /var/www/html/
        sudo rm /var/www/html/index.html
echo -en "\033[0;35m Установка успешно завершена \033[0m \n"
echo 'Рекомендуется перезапустить систему. Рестарт? (y/n)' && read x && [[ "$x" == "y" ]] && /sbin/reboot;
