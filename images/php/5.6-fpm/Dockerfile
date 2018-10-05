FROM php:5.6-fpm

LABEL maintainer="Matias Ramirez <mramirez@summasolutions.net>"

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data --enable-intl --enable-opcache --enable-zip

RUN apt-get update

RUN \
  apt-get install -y \
  libcurl4-gnutls-dev \
  libxml2-dev \
  libssl-dev

RUN \
    /usr/local/bin/docker-php-ext-install \
    dom \
    pcntl \
    posix

# Configure PHP
# php module build deps
RUN \
  apt-get install -y \
  g++ \
  autoconf \
  libbz2-dev \
  libltdl-dev \
  libjpeg62-turbo-dev \
  libfreetype6-dev \
  libxpm-dev \
  libimlib2-dev \
  libicu-dev \
  libmcrypt-dev \
  libxslt1-dev \

  re2c \
  libpng++-dev \
  libvpx-dev \
  zlib1g-dev \
  libgd-dev \
  libtidy-dev \
  libmagic-dev \
  libexif-dev \
  file \
  libssh2-1-dev \
  libjpeg-dev \
  gnupg \
  git \
  curl \
  vim \
  wget \
  librabbitmq-dev \
  libzip-dev

# https://devdocs.magento.com/guides/v2.3/install-gde/system-requirements-tech.html
RUN \
    /usr/local/bin/docker-php-ext-install \
    pdo \
    sockets \
    pdo_mysql \
    mysqli \
    mbstring \
    mcrypt \
    hash \
    simplexml \
    xsl \
    soap \
    intl \
    bcmath \
    json \
    opcache \
    zip


# Make sure the volume mount point is empty
RUN rm -rf /var/www/html/*

# Create .ssh file
# RUN mkdir /var/www/.ssh

# Set www-data as owner for /var/www
RUN chown -R www-data:www-data /var/www/
RUN chmod -R g+w /var/www/

# Create log folders
RUN rm -rf /var/log/php-fpm # Delete if exist
RUN mkdir /var/log/php-fpm && \
    touch /var/log/php-fpm/access.log && \
    touch /var/log/php-fpm/fpm-error.log && \
    touch /var/log/php-fpm/fpm-php.www.log && \
    chown -R www-data:www-data /var/log/php-fpm

RUN docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-png-dir=/usr \
    && docker-php-ext-install gd

#RUN curl -sS https://getcomposer.org/installer | \
#  php -- --install-dir=/usr/local/bin --filename=composer

#RUN pecl install -o -f xdebug


# ENV PHP_MEMORY_LIMIT 2G
# ENV PHP_PORT 9000
# ENV PHP_PM dynamic
# ENV PHP_PM_MAX_CHILDREN 10
# ENV PHP_PM_START_SERVERS 4
# ENV PHP_PM_MIN_SPARE_SERVERS 2
# ENV PHP_PM_MAX_SPARE_SERVERS 6
# ENV APP_MAGE_MODE default