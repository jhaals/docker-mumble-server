FROM ubuntu
MAINTAINER Johan Haals <johan.haals@gmail.com>

RUN apt-get update
#RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ruby mumble-server libsqlite3-dev ruby-dev build-essential
RUN gem install data_mapper --no-rdoc --no-ri
RUN gem install dm-sqlite-adapter --no-rdoc --no-ri
ADD . /

EXPOSE 64738/tcp 64738/udp
CMD ["/start.sh"]
