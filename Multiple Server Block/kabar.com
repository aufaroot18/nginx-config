# config server kabar
server {
	# port server
	listen 80 default_server;
	listen [::]:80 default_server;

	# lokasi document
	root /var/www/html/kabar;
	# tambah index.php
	index index.php index.html index.htm index.nginx-debian.html;

	# nama server
	server_name kabarlinux.com;

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
