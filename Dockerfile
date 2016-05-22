FROM chambana/uwsgi-php:latest

MAINTAINER Josh King <jking@chambana.net>

RUN apt-get -qq update && \
	apt-get install -y --no-install-recommends roundcube-core \
                                             roundcube-pgsql \
                                             roundcube-plugins \
                                             roundcube-plugins-extra && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

ADD files/uwsgi/roundcube.conf /etc/uwsgi/apps-available/roundcube.conf
ADD files/dbconfig/roundcube.conf /etc/dbconfig-common/roundcube.conf

EXPOSE 80

CMD ["/bin/init.sh"]
