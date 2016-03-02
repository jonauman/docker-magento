#!/bin/bash

docker-compose up -d

CONTAINER_ID=$(docker ps|grep 'alexcheng/magento'|awk '{print $1}')

docker exec -it $CONTAINER_ID install-sampledata
docker exec -it $CONTAINER_ID install-magento

OS=$(uname)

# setup hostname in /etc/hosts
if [ $uname == 'Darwin' ]; then
  eval "$(docker-machine env default)"
  IP=$(docker-machine ls default|tail -1 |grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')
  sudo echo "$IP local.magento" >> /etc/hosts
else
  echo 'Add the following entry to the hosts file of your host computer'
  echo '[VM IP] local.magento'
fi

echo "You may now reach your server by typing the following in a browser:"
echo "    http://local.magento"
