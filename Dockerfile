FROM debian:jessie

RUN apt-get update -yqq && apt-get upgrade -yqq

# Ruby
RUN apt-get -yqq update
RUN apt-get -yqq install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev curl git-core libffi-dev && apt-get clean

RUN git clone https://github.com/sstephenson/ruby-build.git && cd ruby-build && ./install.sh

ENV CONFIGURE_OPTS --disable-install-rdoc
RUN echo "gem: --no-document" >> ~/.gemrc
RUN ruby-build 2.3.2 /usr/local
RUN rm -r ruby-build

# should be linked to gems conatainer so that gems can persist
# between deployments.
ENV GEM_HOME /ruby_gems/2.3
ENV PATH /ruby_gems/2.3/bin:$PATH

# Nginx
RUN apt-get install -yqq nginx --fix-missing
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Runit
RUN touch /etc/inittab
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q runit

# Certbot
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install certbot -yq -t jessie-backports

# Cron
RUN apt-get install -y cron

# Tidy up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ADD . /app

WORKDIR /app

COPY config/docker/my_init.d /etc/my_init.d
COPY config/docker/runit /etc/service
COPY config/docker/bin/renew_cert.sh /etc/cron.weekly/renew_cert.sh
COPY config/docker/sites-available/default /etc/nginx/sites-available/default

RUN mkdir /tmp/sockets

EXPOSE 80
EXPOSE 443

ENTRYPOINT config/docker/bin/startup.sh

