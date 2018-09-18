FROM alpine:latest

LABEL Maintainer="Serge NOEL <serge.noel@net6a.com>"

# Install needed packages
RUN apk update \
    && apk add nginx php7-fpm php7-gd php7-session php7-simplexml php7-xml php7-curl php7-ldap php7-mbstring php7-zip php7-json php7-mysqli php7-imap \
       php7-intl php7-openssl php7-sqlite3 php7-pdo_mysql php7-oauth php7-imagick php7-snmp php7-xmlreader php7-pdo_sqlite php7-session php7-gettext \
       php7-mailparse php7-iconv php7-curl php7-pdo_pgsql php7-imap php7-xdebug php7-mcrypt php7-dom php7-pdo php7-bz2 php7-mysqli php7-xmlwriter \
       zip wget supervisor curl 

# Prepare for loggin
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && ln -sf /dev/stderr /var/log/fpm.err.log \
    && ln -sf /dev/stdout /var/log/fpm.log

# Copy configuration files
COPY Files/ /

# Modify access to some files
RUN mkdir -p /var/run/nginx \
    && mkdir /var/www/html \
    && chown nginx: /var/www/html

# This part must be writeable
VOLUME /var/www/html

# Expose http port
EXPOSE 80

# launch supervisor
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/supervisor.conf"]

