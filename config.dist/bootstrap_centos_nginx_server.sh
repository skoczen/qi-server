#!/bin/bash
rpm -ivh -y http://repo.webtatic.com/yum/centos/5/`uname -i`/webtatic-release-5-1.noarch.rpm
yum install -y --enablerepo=webtatic git
# poss nginx solution
wget http://dl.iuscommunity.org/pub/ius/stable/Redhat/5/x86_64/epel-release-1-1.ius.el5.noarch.rpm
wget http://dl.iuscommunity.org/pub/ius/stable/Redhat/5/x86_64/ius-release-1.0-6.ius.el5.noarch.rpm
rpm -Uvh epel-release-1-1.ius.el5.noarch.rpm ius-release-1.0-6.ius.el5.noarch.rpm
yum install -y nginx
yum install -y python26 python26-setuptools python26-devel python26-devel.x86_64 mysql-devel.x86_64 sqlite3 gmp rabbitmq-server memcached hg libjpeg-devel zlib-devel freetype-devel
# eventually memcached will get its own server, but not right now.
cd /etc/init.d; wget https://github.com/ask/celery/raw/master/contrib/generic-init.d/celeryd --no-check-certificate; chmod +x celeryd
sed '1d' celeryd > celeryd.tmp
echo "# chkconfig: 2345 20 80" > celeryd
echo "# description: The Celery start-stop-script" >> celeryd
cat celeryd.tmp >> celeryd
rm celeryd.tmp
# rabbitmqctl add_user user pass
# rabbitmqctl add_vhost vhost
# rabbitmqctl set_permissions -p vhost user ".*" ".*" ".*"
easy_install-2.6 pip
echo 'alias python=python26' >> ~/.bashrc
echo 'VIRTUALENVWRAPPER_PYTHON=/usr/bin/python26' >> ~/.bashrc
source ~/.bashrc
mkdir /var/www
mkdir /var/backups
pip install --upgrade pip virtualenv virtualenvwrapper
cd ~;mkdir .virtualenvs
chmod +x /root
echo 'source /usr/bin/virtualenvwrapper.sh' >> .bashrc
source ~/.bashrc
cd /var/www
git clone http://qiserver.skoczen.webfactional.com/qiserver.git qiserver.git
cd qiserver.git;git checkout live
cat /var/www/qiserver.git/config.dist/authorized_keys >> ~/.ssh/authorized_keys
mkvirtualenv qiserver
echo 'cd /var/www/qiserver.git' >> ~/.virtualenvs/qiserver/bin/postactivate
workon qiserver
pip install -r requirements.txt 
echo 'mysql_config = /usr/bin/mysql_config' >> ~/.virtualenvs/qiserver/build/mysql-python/site.cfg
pip install -r requirements.txt 
mkdir /var/log/celery
mv /etc/default/celeryd /etc/default/celeryd.bak
ln -s /var/www/qiserver.git/config.dist/celeryd /etc/default/celeryd;chmod +x /etc/default/celeryd
mv /etc/nginx/nginx.conf /etc/default/nginx.conf.bak
ln -s /var/www/qiserver.git/config.dist/nginx.conf /etc/nginx/nginx.conf
chkconfig --add memcached
chkconfig --add rabbitmq-server
# chkconfig --add celeryd
chkconfig --add nginx
service memcached start
service rabbitmq-server start
# service celeryd start
service nginx start

