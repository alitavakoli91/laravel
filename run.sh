#Install laravel dependencies
docker run --rm -v $(pwd):/app composer install

#change directory owner
sudo chown -R $USER:$USER .

#run builder
docker-compose build

#run docker-compose
docker-compose up -d

#show docker-compose information
echo "show up containers"
docker-compose ps
sleep 2
echo "show used images"
docker-compose images
sleep 2
echo "show exposed ports"
netstat -plntu

#make env file
cp .env.example .env

#laravel application key and clear cache configuration
docker-compose exec app php artisan key:generate
sleep 2
docker-compose exec app php artisan config:cache
sleep 2

#laravel migration data with database
docker-compose exec app php artisan migrate

#set permission
docker exec -it app chown -R www-data /var/www/html/storage/

#success msg
echo "open http://localhost"


