FROM ubuntu
MAINTAINER Johan Haals <johan@haals.se>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y supervisor ruby2.0 mumble-server libsqlite3-dev ruby2.0-dev build-essential

RUN gem2.0 install data_mapper --no-rdoc --no-ri
RUN gem2.0 install dm-sqlite-adapter --no-rdoc --no-ri

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD start.sh /
ADD mumble.rb /
ADD mumble-server.ini /
RUN chmod +x /start.sh


EXPOSE 64738
CMD ["/start.sh"]
