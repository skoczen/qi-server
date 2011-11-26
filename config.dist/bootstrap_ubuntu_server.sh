aptitude install -y percona-server-client-5.1 percona-server-common percona-server-server-5.1 libmysqlclient-dev libpq-dev sqlite3 python2.7 python-setuptools python2.7-dev build-essential xvfb firefox htop mercurial libjpeg-dev zlib1g-dev  libjpeg62 libjpeg62-dev lib-zlib libfreetype6 libfreetype6-dev apache2-utils redis-server memcached libcurl4-dev libidn11 libidn11-dev libdap-dev librtmp-dev postgresql upstart chkconfig libmysql++-dev htop libcurl curl libcurl4-gnutls-dev postgresql
sudo apt-get install -y ruby rubygems ruby1.8-dev ruby1.8 ri1.8 rdoc1.8 irb1.8
sudo apt-get install -y libreadline-ruby1.8 libruby1.8 libopenssl-ruby
sudo apt-get install -y libxslt-dev libxml2-dev
gem install nokogiri
gem install backup
gem install fog

easy_install-2.7 pip
echo 'VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7' >> ~/.profile
source ~/.profile
mkdir /var/www
rm -rf /var/www/*
pip install --upgrade pip virtualenv virtualenvwrapper
cd ~;mkdir .virtualenvs
chmod +x /root
echo 'source /usr/local/bin/virtualenvwrapper.sh' >> .profile
source ~/.profile

cd /var/www
git clone git@github.com:skoczen/qi-server.git qiserver.git
mv /etc/nginx/nginx.conf /etc/default/nginx.conf.bak
ln -s /var/www/qiserver.git/config.dist/nginx.conf /etc/nginx/nginx.conf
