# config server kabar
server {
	# port server
	listen 80;

	# lokasi document
	root /var/www/html/kamu;
	# tambah index.php
	index index.php index.html index.htm index.nginx-debian.html;

	# nama server
	server_name kamu.com;

	location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        # lokasi php-fpm sock
        fastcgi_pass unix:/run/php/php7.0-fpm.sock;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
