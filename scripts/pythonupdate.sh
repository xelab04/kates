#! /bin/bash
sudo zypper install rpmdevtools make gcc-c++ gcc automake autoconf libtool

wget https://www.openssl.org/source/openssl-1.1.1m.tar.gz
tar zxvf openssl-1.1.1m.tar.gz
cd openssl-1.1.1m
./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl no-ssl2
make
make test
sudo make install


echo '
export PATH=/usr/local/openssl/bin:$PATH
export PATH=/usr/local/python/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/openssl/lib
export LDFLAGS="-L /usr/local/openssl/lib -Wl,-rpath,/usr/local/openssl/lib"
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/openssl/lib/
export LC_ALL="en_US.UTF-8"
' >> ~/.bashrc

source ~/.bashrc

sudo zypper si -d python3
cd ~/
wget https://www.python.org/ftp/python/3.10.9/Python-3.10.9.tgz
tar -xvzf Python-*.tgz
cd Python-*/
./configure --prefix=/usr/local/python/ --with-openssl=/usr/local/openssl --enable-optimizations
make
sudo make install
