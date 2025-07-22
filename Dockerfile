FROM dunglas/frankenphp

RUN install-php-extensions \
	pdo_mysql \
	gd \
	intl \
	zip \
	opcache

ENV SERVER_NAME=:80

COPY . /app

WORKDIR /app

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN composer install --no-interaction --prefer-dist

