#!/bin/bash

# Tải về và cài đặt Pterodactyl Panel
echo "Installing Pterodactyl Panel..."
curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz
tar -xzvf panel.tar.gz
mv panel /var/www/pterodactyl

# Cấu hình database (sử dụng SQLite hoặc MariaDB tùy ý)
echo "Configuring database..."
apt-get install -y mariadb-server
mysql -e "CREATE DATABASE pterodactyl;"
mysql -e "CREATE USER 'ptero'@'localhost' IDENTIFIED BY 'password';"
mysql -e "GRANT ALL PRIVILEGES ON pterodactyl.* TO 'ptero'@'localhost';"

# Cài đặt và khởi chạy
cd /var/www/pterodactyl
cp .env.example .env
php artisan key:generate
php artisan migrate --force

# Khởi động Pterodactyl
php artisan serve --host=0.0.0.0 --port=8080 &
