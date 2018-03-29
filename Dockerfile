FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
   apache2 \
   build-essential \
   libssl-dev \
   php5-mysql \
   libapache2-mod-php5 \
   lftp \
   php5-gd \
   php5-curl \
   mysql-server \
   proftpd-basic \
   curl \
   mysql-client \
   php5-cli \
   ca-certificates \
   zip \
   unzip \
   git

RUN curl -skL https://deb.nodesource.com/setup_9.x | bash && \
    apt-get install -y nodejs

COPY extra/adminer.php /var/www/html/adminer.php
COPY extra/wordpress/ /var/www/html/
COPY docker/configs/apache2.conf /etc/apache2/apache2.conf
COPY docker/configs/proftpd.conf /etc/proftpd/proftpd.conf
COPY docker/database/init_database.sql /var/www/builddir/init_database.sql
COPY docker/database/database.sql /var/www/builddir/database.sql
COPY docker/bootstrap.sh /var/www/builddir/bootstrap.sh
COPY docker/build.sh /var/www/builddir/build.sh
COPY src /var/www/builddir/src
COPY package.json /var/www/builddir/package.json
COPY gulpfile.js /var/www/builddir/gulpfile.js

RUN php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" \
  && php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('/tmp/composer-setup.php'); } echo PHP_EOL;" \
  && php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN rm /var/www/html/index.html && chown -R root:www-data var/www/html && chmod -R 0775 var/www/html

RUN echo "Node version" && node --version && echo "npm version" && npm --version && composer --version

RUN chmod +x /var/www/builddir/bootstrap.sh

CMD /var/www/builddir/bootstrap.sh
