# alpine-ltmp
> A pure ltmp environment running in docker base on alpine 3.7,the total size is about 500MB,the compressed Size is 172M.

```
versions:
tengine: 2.2.0 (nginx/1.8.1)
php: 7.1.17
mysql: Ver 5.6.38-83.0 Distrib 10.1.32-MariaDB
```
## PHP Extensions

- php7-ctype
- php7-curl
- php7-dom
- php7-exif
- php7-fileinfo
- php7-gd
- php7-gettext
- php7-iconv
- php7-imagick
- php7-json
- php7-mbstring
- php7-mcrypt
- php7-memcached
- php7-mysqli
- php7-mysqlnd
- php7-opcache
- php7-openssl
- php7-pcntl
- php7-pdo
- php7-pdo_mysql
- php7-pdo_pgsql
- php7-pdo_sqlite
- php7-posix
- php7-redis
- php7-session
- php7-simplexml
- php7-sockets
- php7-sqlite3
- php7-xml
- php7-xmlwriter
- php7-zli
- php7-fpm

### Docker Hub

```bash
# pull the image
docker pull edwin001/alpine-ltmp

# start the container
docker run -itd -p80:80 -p3306:3306 --name alpine-ltmp edwin001/alpine-ltmp:latest

# or mount your application code
docker run -itd -p80:80 -p3306:3306 -v /Your-Code-Path:/usr/share/nginx/html --name alpine-ltmp edwin001/alpine-ltmp:latest

````

### Build Yourself 

```bash
cd alpine-ltmp;
docker build -t alpine-ltmp:0.1 .

# default index.php is phpinfo if without '-v'
docker run -itd -p80:80 -p3306:3306 --name alpine-ltmp alpine-lnmp:0.1

# or mount your application code
docker run -itd -p80:80 -p3306:3306 -v /Your-Code-Path:/usr/share/nginx/html --name alpine-ltmp alpine-ltmp:0.1
```

### End 
![phpinfo](http://ww1.sinaimg.cn/mw690/7c0d9e07ly1ftf17hupfxj21sa0xiqes.jpg)
