#!/usr/bin/env bash
set -Eeuo pipefail

echo -en '\033[1;33mВыберите ваш язык использования/Select your language of use (rus=1 , eng=2)\033[0m \n'
	read lang
	if [[ $lang = 1 ]]
	then
		echo -en '\033[1;33mНачинается процесс обновления системы \033[0m \n'
				sudo apt update && apt full-upgrade -y
		echo -en '\033[1;33mНачинается очистка системы \033[0m \n'
				sudo apt autoremove -y && apt autoclean -y
		echo -en '\033[1;33mСистема обновлена \033[0m \n'
		echo -en '\033[1;33mНачинается установка Apache2..\033[0m \n'
				sudo apt install apache2 apache2-utils -y
				sudo systemctl enable apache2
				sudo systemctl start apache2
		echo -en '\033[1;33mНачинается установка Mysql.. \033[0m \n'
				sudo apt install mysql-client mysql-server -y
				
		status=1
			while [[ $status = 1 ]]
			do
				echo -en '\033[1;33mВведите пароль root для mysql... \033[0m \n'
					read pswrd
				echo -en '\033[1;33mПодтвердите... \033[0m \n'
					read pswrds
				if [ $pswrd = $pswrds ]
				then
				echo -en '\033[1;33mПодтвержденно \033[0m \n'
				status=0
				mysql --execute="ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by '"$pswrds"';"
				else
				echo -en '\033[1;33mПароль не совпадает \033[0m \n'
				status=1
				fi
			done		
				sudo mysql_secure_installation
		echo -en '\033[1;33mНачинается установка Php7.4.. \033[0m \n'
				sudo apt install php7.4 php7.4-mysql libapache2-mod-php7.4 php7.4-cli php7.4-cgi php7.4-gd php7.4-curl php7.4-dom php7.4-imagick php7.4-mbstring php7.4-zip php7.4-intl -y
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
	elif [[ $lang = 2 ]]
	then
		echo -en '\033[1;33mThe system update process starts \033[0m \n'
				sudo apt update && apt full-upgrade -y
		echo -en '\033[1;33mSystem cleanup starts \033[0m \n'
				sudo apt autoremove -y && apt autoclean -y
		echo -en '\033[1;33mSystem updated \033[0m \n'
		echo -en '\033[1;33mInstallation of Apache2 begins..\033[0m \n'
				sudo apt install apache2 apache2-utils -y
				sudo systemctl enable apache2
				sudo systemctl start apache2
		echo -en '\033[1;33mMysql installation starts.. \033[0m \n'
				sudo apt install mysql-client mysql-server -y
				
						status=1
			while [[ $status = 1 ]]
			do
				echo -en '\033[1;33mEnter root password for mysql... \033[0m \n'
					read pswrd
				echo -en '\033[1;33mConfirm... \033[0m \n'
					read pswrds
				if [ $pswrd = $pswrds ]
				then
				echo -en '\033[1;33mConfirmed \033[0m \n'
				status=0
				mysql --execute="ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password by '"$pswrds"';"
				else
				echo -en '\033[1;33mPassword doesnt match \033[0m \n'
				status=1
				fi
			done
				sudo mysql_secure_installation
		echo -en '\033[1;33mPhp7.4 installation starts.. \033[0m \n'
				sudo apt install php7.4 php7.4-mysql libapache2-mod-php7.4 php7.4-cli php7.4-cgi php7.4-gd php7.4-curl php7.4-dom php7.4-imagick php7.4-mbstring php7.4-zip php7.4-intl -y
				sudo a2enmod rewrite
				sudo systemctl restart apache2
		echo -en '\033[1;33mWordpress download starts.. \033[0m \n'
				wget -c http://wordpress.org/latest.tar.gz
		echo -en '\033[1;33mIt starts unzipping Wordpress and installing it in /var/www/html... \033[0m \n'
				tar -xzvf latest.tar.gz
				sudo rsync -av wordpress/* /var/www/html/
				sudo chown -R www-data:www-data /var/www/html/
				sudo chmod -R 755 /var/www/html/
				sudo rm /var/www/html/index.html
		echo -en "\033[0;35m Installation completed successfully \033[0m \n"
		echo 'It is recommended to restart the system. Restart? (y/n)' && read x && [[ "$x" == "y" ]] && /sbin/reboot;
	
	fi
