# Installation

docker network create RichiNet
docker-compose up -d --build

enter containers and set /var/www/data to a+w

docker exec -it webtreesdb mysql -u root -pdbrootpassword
ALTER USER webtrees IDENTIFIED WITH mysql_native_password BY 'dbpassword';
FLUSH PRIVILEGES;

rsync -v /richi/Privat/Data/Webtrees-Data/media/* root@boxbackup.redirectme.net:/var/lib/docker/volumes/webtrees-docker_Webtrees-Data/_data/media/