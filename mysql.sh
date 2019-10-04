#!/bin/bash
# on user login
# put your script in echo /etc/profile.d/


# on user login, make a mysql database, with a user, using their FSU username, and password as their fsu password
# send them an email with this information
# allow them to reset their password somehow

# create noob file w/ /etc/skel for first login
if [ -e /home/$USER/noob ]
then
# create random password
    #PASSWDDB="$(openssl rand -base64 12)"
    #uncomment this for a random password
    PASSWDDB=welcome123
    # replace "-" with "_" for database username
    #MAINDB=${USER_NAME//[^a-zA-Z0-9]/_}
    MAINDB=$USER

    # leo mysql info:
    # mio
    # UsVMoa3lCnyPn6u

    rootpasswd=UsVMoa3lCnyPn6u


    # If /root/.my.cnf exists then it won't ask for root password
    if [ -f /root/.my.cnf ]; then

        mysql -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
        mysql -e "CREATE USER ${MAINDB}@localhost IDENTIFIED BY '${PASSWDDB}';"
        mysql -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${MAINDB}'@'localhost';"
        mysql -e "FLUSH PRIVILEGES;"

    # If /root/.my.cnf doesn't exist then it'll ask for root password   
    else
        echo "Please enter root user MySQL password!"
        echo "Note: password will be hidden when typing"
        #read -sp rootpasswd
        mysql -umio -p${rootpasswd} -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
        mysql -umio -p${rootpasswd} -e "CREATE USER ${MAINDB}@localhost IDENTIFIED BY '${PASSWDDB}';"
        mysql -umio -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${MAINDB}'@'localhost';"
        mysql -umio -p${rootpasswd} -e "FLUSH PRIVILEGES;"
    fi
# remove flag file for first login
rm -f /home/$USER/noob
fi
# subsituite root/mio for admin account
# check virtualmin for this

# make a mysql database for user
# /home/$USER/.profile

#TODO: access denied mio, cant create database
# make sure if flag works
# https://alvinalexander.com/blog/post/mysql/show-users-i-ve-created-in-mysql-database