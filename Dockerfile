FROM php:7-cli

# Install git for composer
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    git

# Install opcache, zip
RUN docker-php-ext-install opcache zip

# Enable and configure xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require symfony/phpunit-bridge:^3.2 symfony/debug:^3.2

# Add global composer bins to PATH
ENV PATH /root/.composer/vendor/bin:$PATH

# Trigger pre-install of symfony flavored phpunit to have it cached
RUN simple-phpunit --version
