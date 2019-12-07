FROM nginx:latest
RUN apt-get clean && apt-get update && apt-get install -y \
  spawn-fcgi \
  fcgiwrap \
  less vim \
  unzip \
  && sed -i 's/www-data/nginx/g' /etc/init.d/fcgiwrap \
  && chown nginx:nginx /etc/init.d/fcgiwrap

COPY vhost.conf /etc/nginx/conf.d/default.conf
ADD https://github.com/fisharebest/webtrees/releases/download/1.7.14/webtrees-1.7.14.zip /var/www/
RUN cd /var/www \
  && unzip /var/www/webtrees-1.7.14.zip \
  && mv webtrees/* . \
  && rmdir webtrees \
  && rm webtrees-1.7.14.zip

CMD /etc/init.d/fcgiwrap start \
    && nginx -g 'daemon off;'
