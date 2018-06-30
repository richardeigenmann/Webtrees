FROM nginx:1.13
RUN apt-get clean && apt-get update && apt-get install -y \
  spawn-fcgi \
  fcgiwrap \
  less vim \
  unzip \
  && sed -i 's/www-data/nginx/g' /etc/init.d/fcgiwrap \
  && chown nginx:nginx /etc/init.d/fcgiwrap

COPY vhost.conf /etc/nginx/conf.d/default.conf
ADD https://launchpad.net/webtrees/1.7/1.7.9/+download/webtrees-1.7.9.zip /var/www/
RUN cd /var/www \
  && unzip /var/www/webtrees-1.7.9.zip \
  && mv webtrees/* . \
  && rmdir webtrees \
  && rm webtrees-1.7.9.zip

CMD /etc/init.d/fcgiwrap start \
    && nginx -g 'daemon off;'
