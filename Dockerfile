FROM alpine:3.24
LABEL Author="Serge NOEL <serge.noel@net6a.com>"

# Install needed packages
RUN apk update \
    && apk add nginx \
       php85-fpm php85-gd php85-session php85-simplexml php85-xml php85-curl php85-ldap php85-mbstring php85-zip php85-json php85-mysqli php85-imap \
       php85-intl php85-openssl php85-sqlite3 php85-pdo_mysql php85-snmp php85-xmlreader php85-pdo_sqlite php85-session php85-gettext \
       php85-iconv php85-curl php85-pdo_pgsql php85-xdebug php85-dom php85-pdo php85-bz2 php85-mysqli php85-xmlwriter \
       zip wget supervisor curl

# Copy configuration files
COPY Files/ /

# This part must be writeable
VOLUME /var/www/html/download

# Expose http port
EXPOSE 8080

# launch supervisor
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/supervisor.conf"]

