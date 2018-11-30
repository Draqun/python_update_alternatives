#!/usr/bin/env bash

sudo -v
sudo update-alternatives --remove-all python

test -f /usr/bin/python2
python2_exists=$?

test -f /usr/bin/python3
python3_exists=$?

sed -i.bak '/enable_python2/d' ~/.bashrc
sed -i.bak '/enable_python3/d' ~/.bashrc

if [ 0 -eq $python2_exists ]
then
	sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 10
	echo "alias enable_python2='sudo -v && sudo update-alternatives --set python /usr/bin/python2'" >> ~/.bashrc
fi

if [ 0 -eq $python3_exists ]
then
	sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 20
	echo "alias enable_python3='sudo -v && sudo update-alternatives --set python /usr/bin/python3'" >> ~/.bashrc
fi


echo "Update finished with success"
if [ 0 -eq $python2_exists ]
then
	echo "To enable Python2 just run enable_python2"
fi

if [ 0 -eq $python3_exists ]
then
	echo "To enable Python3 just run enable_python3"
fi

