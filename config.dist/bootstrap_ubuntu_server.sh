#!/bin/bash
# do this by hand
# cd /var/www
# aptitude install -y git
# git clone git@github.com:skoczen/qi-server.git qiserver.git

# has nginx, memcached, mysql installed.
aptitude install -y git python-setuptools python2.6-dev python-virtualenv python-pip libmysqld-dev sqlite libgmp3-dev  mercurial libjpeg62-dev zlib1g-dev libfreetype6-dev

# eventually rabbitmq-server
# eventuall also memcached will get its own server, but not right now.
cd /etc/init.d; wget https://github.com/ask/celery/raw/master/contrib/generic-init.d/celeryd --no-check-certificate; chmod +x celeryd
sed '1d' celeryd > celeryd.tmp
echo "# chkconfig: 2345 20 80" > celeryd
echo "# description: The Celery start-stop-script" >> celeryd
cat celeryd.tmp >> celeryd
rm celeryd.tmp
# rabbitmqctl add_user user pass
# rabbitmqctl add_vhost vhost
# rabbitmqctl set_permissions -p vhost user ".*" ".*" ".*"
echo 'alias python=python26' >> ~/.bashrc
echo 'VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.6' >> ~/.bashrc
source ~/.bashrc
mkdir /var/www
mkdir /var/backups
pip install --upgrade pip virtualenv virtualenvwrapper
cd ~;mkdir .virtualenvs
chmod +x /root
echo 'source /usr/local/bin/virtualenvwrapper.sh' >> .bashrc
source ~/.bashrc
cd /var/www
# git clone http://qiserver.skoczen.webfactional.com/qiserver.git qiserver.git
cd qiserver.git;git checkout master
cat /var/www/qiserver.git/config.dist/authorized_keys >> ~/.ssh/authorized_keys
mkvirtualenv qiserver
echo 'cd /var/www/qiserver.git' >> ~/.virtualenvs/qiserver/bin/postactivate
workon qiserver
pip install -r requirements.txt 
# echo 'mysql_config = /usr/bin/mysql_config' >> ~/.virtualenvs/qiserver/build/mysql-python/site.cfg
# pip install -r requirements.txt 
mkdir /var/log/celery
mv /etc/default/celeryd /etc/default/celeryd.bak
ln -s /var/www/qiserver.git/config.dist/celeryd /etc/default/celeryd;chmod +x /etc/default/celeryd
mv /etc/nginx/nginx.conf /etc/default/nginx.conf.bak
ln -s /var/www/qiserver.git/config.dist/nginx.conf /etc/nginx/nginx.conf


# chkconfig --add memcached
# chkconfig --add rabbitmq-server
# # chkconfig --add celeryd
# chkconfig --add nginx
# service memcached start
# service rabbitmq-server start
# # service celeryd start
# service nginx start

