FROM php:5.6-apache
ADD base_path.p /tmp/base_path.p
RUN apt-get update && apt-get install -y --no-install-recommends patch graphviz \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /tmp/xhprof \
 && curl -s -L https://github.com/phacility/xhprof/archive/master.tar.gz | tar -C /tmp/xhprof -xz --strip-components=1 \
 && (cd /tmp/xhprof && patch -p1 < /tmp/base_path.p) \
 && rm -rf /var/www/html \
 && mv /tmp/xhprof/xhprof_html /var/www/html \
 && mv /tmp/xhprof/xhprof_lib /var/www/xhprof_lib \
 && rm -rf /tmp/xhprof \
 && echo 'date.timezone = UTC' > /usr/local/etc/php/conf.d/zz-date.ini

VOLUME /tmp
EXPOSE 80
