# Dockerfile
FROM php:7.2.34-fpm-alpine3.12

# Install system dependencies
RUN apk --no-cache add \
    php-session \
    php-tokenizer \
    php-cli \
    php-fpm \
    php-common \
    php-xml \
    php-zip \
    php-ctype \
    php-curl \
    php-dom \
    php-gd \
    php-fileinfo \
    php-mbstring \
    php-openssl \
    php-pdo \
    php-pdo_mysql \
    php-session \
    php-tokenizer \
    php-xml \
    php-ctype \
    php-xmlwriter \
    php-simplexml \
    php-bcmath \
    git \
    vim \
    unzip \
    mysql-client \
    mariadb-client \
    curl

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# install node js
RUN apk add --update nodejs-current npm

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo_mysql
RUN docker-php-ext-enable mysqli pdo_mysql


# Copy the application files
COPY . /var/www/html

# Set working directory
WORKDIR /var/www/html

# Install PHP dependencies, ini tidak selalu berhasil tapi tidak mengapa sih
# RUN composer install

# Install Node.js dependencies
# RUN npm install

# Set permissions for storage and cache
RUN chown -R www-data:www-data /var/www/html/storage
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port 9000 for PHP-FPM
EXPOSE 9000

CMD ["php-fpm"]