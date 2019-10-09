#!/bin/bash
# made by Will Bollock, CCI HelpDesk

# to start, place this script in /etc/profile.d/
# make sure to make it executable (sudo chmod +x mysql.sh)
# lastly, make a file in /etc/skel/ called "noob"
# (sudo touch /etc/skel/noob)




# create noob file w/ /etc/skel for first login (used as a flag for first login)
if [ -e /home/$USER/noob ]
then
# create random password
    PASSWDDB="$(openssl rand -base64 12)"
    #uncomment this for a random password
    #PASSWDDB=welcome123
    # replace "-" with "_" for database username
    #MAINDB=${USER_NAME//[^a-zA-Z0-9]/_}
    MAINDB=$USER

    
    # password for ADMIN mysql account. change this to match the mysql configuration.
    rootpasswd=welcome123

    # If /root/.my.cnf exists then it won't ask for root password
    if [ -f /root/.my.cnf ]; then

        mysql -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
        mysql -e "CREATE USER ${MAINDB}@localhost IDENTIFIED BY '${PASSWDDB}';"
        mysql -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${MAINDB}'@'localhost';"
        mysql -e "FLUSH PRIVILEGES;"

    # If /root/.my.cnf doesn't exist then it'll ask for root password   
    else
        #echo "Please enter root user MySQL password!"
        #echo "Note: password will be hidden when typing"
        #read -sp rootpasswd
        mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
        mysql -uroot -p${rootpasswd} -e "CREATE USER ${MAINDB}@localhost IDENTIFIED BY '${PASSWDDB}';"
        mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${MAINDB}'@'localhost';"
        mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
    fi
# remove flag file for first login
rm -f /home/$USER/noob
fi

# create file for user
echo $MAINDB > /home/$USER/mysqlInfo
echo $PASSWDDB >> /home/$USER/mysqlInfo
