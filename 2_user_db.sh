#!/usr/bin/env bash
set -Eeuo pipefail

echo -en '\033[1;33mВыберите ваш язык использования/Select your language of use (rus=1 , eng=2)\033[0m \n'
	read lang
	if [[ $lang = 1 ]]
	then
		echo -en '\033[1;33mВведите имя пользователя базы данных mysql \033[0m \n'
			read user
			host=localhost
		echo -en '\033[1;33mХотите ли вы сделать пользовательский хост? (по умолчанию localhost) y/n \033[0m \n'
			read host_check
				if [[ $host_check = y ]]
				then
				echo -en '\033[1;33mВведите имя хоста... \033[0m \n'
				read host
				fi
			status=1
			while [[ $status = 1 ]]
			do
				echo -en '\033[1;33mВведите пароль \033[0m \n'
					read pswrd
				echo -en '\033[1;33mПодтвердите... \033[0m \n'
					read pswrds
				if [ $pswrd = $pswrds ]
				then
				echo -en '\033[1;33mПодтвержденно \033[0m \n'
				status=0
				else
				echo -en '\033[1;33mПароль не совпадает \033[0m \n'
				status=1
				fi
			done
			rootuser=root
		echo -en '\033[1;33mХотите ли вы зайти в базу данных с другого юзера? (по умолчанию root) y/n \033[0m \n'
				read root_check
			if [[ $root_check = y ]]
				then
				echo -en '\033[1;33mВведите имя пользователя... \033[0m \n'
					read rootuser
			fi
		#mysql --user=$rootuser -p --execute="CREATE USER '"${user}"'@'"${host}"' IDENTIFIED BY '"${pswrds}"';"
		echo -en '\033[1;33mДобавление пользователя завершено\033[0m \n'
		echo -en '\033[1;33mхотите ли вы добавить права пользователя? (GRANT ALL PRIVILEGES) y/n \033[0m \n'
			read grant_check
		echo -en '\033[1;33mВы хотите дать права на все базы данных? y/n \033[0m \n'
			read all_db
		if [[ $grant_check = y ]]
		then
			if [[ $all_db = y ]]
			then
			mysql --user=$rootuser -p --execute="CREATE USER '"${user}"'@'"${host}"' IDENTIFIED BY '"${pswrds}"';grant all privileges on *.* to '"${user}"'@'"${host}"';flush privileges;"
			else
			mysql --user=$rootuser -p --execute="show databases;"
			echo -en '\033[1;33mВведите базу данных...(если отсутствует то после выдачи прав создайте базу данных)\033[0m \n'
				read db_check
			mysql --user=$rootuser -p --execute="CREATE USER '"${user}"'@'"${host}"' IDENTIFIED BY '"${pswrds}"';grant all privileges on "${db_check}".* to '"${user}"'@'"${host}"';flush privileges;"
			fi
		fi

		echo -en '\033[1;33mНастройка пользователя завершена \033[0m \n'
		
		echo -en '\033[1;33mСоздание базы данных... \033[0m \n'
		statusdb=1
		while [[ $statusdb = 1 ]]
		do
		echo -en '\033[1;33mВведите наименование базы данных \033[0m \n'
				read A
		echo -en '\033[1;33mПодтвердите наименование... \033[0m \n'
				read B
		if [ $A = $B ]
		then
		echo -en '\033[1;33mПодтвержденно \033[0m \n'
		statusdb=0
		C=$B
		else
		echo -en '\033[1;33mНе совпадают \033[0m \n'
		statusdb=1
		fi
		done
		mysql -u$rootuser -p --execute="create database "$C" ;"
		echo -en '\033[1;33 Wordpress готов к работе! \033[0m \n'
		
	elif [[ $lang = 2 ]]
	then		echo -en '\033[1;33mEnter mysql database username \033[0m \n'
			read user
			host=localhost
		echo -en '\033[1;33mDo you want to make a custom host? (default localhost) y/n \033[0m \n'
			read host_check
				if [[ $host_check = y ]]
				then
				echo -en '\033[1;33mEnter hostname... \033[0m \n'
				read host
				fi
			status=1
			while [[ $status = 1 ]]
			do
				echo -en '\033[1;33mEnter password \033[0m \n'
					read pswrd
				echo -en '\033[1;33mConfirm... \033[0m \n'
					read pswrds
				if [ $pswrd = $pswrds ]
				then
				echo -en '\033[1;33mConfirmed \033[0m \n'
				status=0
				else
				echo -en '\033[1;33mPassword doesnt match \033[0m \n'
				status=1
				fi
			done
			rootuser=root
		echo -en '\033[1;33mDo you want to access the database from another user? (default root) y/n \033[0m \n'
				read root_check
			if [[ $root_check = y ]]
				then
				echo -en '\033[1;33mEnter username... \033[0m \n'
					read rootuser
			fi
		#mysql --user=$rootuser -p --execute="CREATE USER '"${user}"'@'"${host}"' IDENTIFIED BY '"${pswrds}"';"
		echo -en '\033[1;33mUser addition completed\033[0m \n'
		echo -en '\033[1;33mDo you want to add user rights? (GRANT ALL PRIVILEGES) y/n \033[0m \n'
			read grant_check
		echo -en '\033[1;33mDo you want to give rights to all databases? y/n \033[0m \n'
			read all_db
		if [[ $grant_check = y ]]
		then
			if [[ $all_db = y ]]
			then
			mysql --user=$rootuser -p --execute="CREATE USER '"${user}"'@'"${host}"' IDENTIFIED BY '"${pswrds}"';grant all privileges on *.* to '"${user}"'@'"${host}"';flush privileges;"
			else
			mysql --user=$rootuser -p --execute="show databases;"
			echo -en '\033[1;33mEnter the database... (if missing, then create the database after granting rights)\033[0m \n'
				read db_check
			mysql --user=$rootuser -p --execute="CREATE USER '"${user}"'@'"${host}"' IDENTIFIED BY '"${pswrds}"';grant all privileges on "${db_check}".* to '"${user}"'@'"${host}"';flush privileges;"
			fi
		fi

		echo -en '\033[1;33mUser setup completed \033[0m \n'
		
		echo -en '\033[1;33mDatabase creation... \033[0m \n'
		statusdb=1
		while [[ $statusdb = 1 ]]
		do
		echo -en '\033[1;33mEnter database name \033[0m \n'
				read A
		echo -en '\033[1;33mConfirm name... \033[0m \n'
				read B
		if [ $A = $B ]
		then
		echo -en '\033[1;33mConfirmed \033[0m \n'
		statusdb=0
		C=$B
		else
		echo -en '\033[1;33mDo not match \033[0m \n'
		statusdb=1
		fi
		done
		mysql -u$rootuser -p --execute="create database "$C" ;"
		echo -en '\033[1;33 Wordpress is ready to go! \033[0m \n'
	fi
	
	
#TEST
#TEST
#TEST
