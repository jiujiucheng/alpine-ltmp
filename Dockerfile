FROM alpine:latest

RUN echo 'http://mirrors.tuna.tsinghua.edu.cn/alpine/v3.7/main' > /etc/apk/repositories; \
    echo 'http://mirrors.tuna.tsinghua.edu.cn/alpine/v3.7/community/' >> /etc/apk/repositories; \
    apk update;

# env
ENV NGINX_VERSION tengine-2.2.0

ENV TENGINE_CONFIG "\
        --prefix=/etc/nginx \
        --sbin-path=/usr/sbin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --pid-path=/var/run/nginx.pid \
        --lock-path=/var/run/nginx.lock \
        --http-client-body-temp-path=/var/cache/nginx/client_temp \
        --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
        --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
        --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
        --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
        --user=nginx \
        --group=nginx \
        --with-http_ssl_module \
        --with-http_realip_module \
        --with-http_addition_module \
        --with-http_sub_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_mp4_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_random_index_module \
        --with-http_secure_link_module \
        --with-http_auth_request_module \
        --with-mail \
        --with-mail_ssl_module \
        --with-ipv6 \
        --with-jemalloc \
    "
WORKDIR /usr/src/


# build essential
RUN apk add gcc g++ autoconf automake make pcre-dev openssl-dev zlib-dev libc-dev  jemalloc-dev \
   && addgroup -S nginx \
   && adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx nginx 


#instal tengine

ADD https://github.com/alibaba/tengine/archive/${NGINX_VERSION}.tar.gz tengine.tar.gz

RUN  tar -zxvf tengine.tar.gz  \
    && cd tengine-${NGINX_VERSION}  \
    && ./configure $TENGINE_CONFIG   \
    && make  \
    && make install  \
    && mkdir -p /usr/share/nginx/html/ \
    && cp -f /etc/nginx/html/* /usr/share/nginx/html \
    && rm -rf /etc/nginx/html/ \
    && mkdir /etc/nginx/conf.d/ 

# install php
RUN apk add php7 \
            php7-ctype \
            php7-curl \
            php7-dom \
            php7-exif \
            php7-fileinfo \
            php7-gd \
            php7-gettext \
            php7-iconv \
            php7-imagick \
            php7-json \
            php7-mbstring \
            php7-mcrypt \
            php7-memcached \
            php7-mysqli \
            php7-mysqlnd \
            php7-opcache \
            php7-openssl \
            php7-pcntl \
            php7-pdo \
            php7-pdo_mysql \
            php7-pdo_pgsql \
            php7-pdo_sqlite \
            php7-posix \
            php7-redis \
            php7-session \
            php7-simplexml \
            php7-sockets \
            php7-sqlite3 \
            php7-xml \
            php7-xmlwriter \
            php7-zlib;


# install php-fpm
RUN apk add php7-fpm


# install mysql
RUN apk add mysql mysql-client;

# copy files
COPY start.sh /root/start.sh
COPY my.cnf /etc/mysql/my.cnf
COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d/default.conf /etc/nginx/conf.d/
COPY index.php /usr/share/nginx/html/index.php


CMD ["/bin/sh", "/root/start.sh"]

