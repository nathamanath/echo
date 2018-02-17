FROM debian:stretch-slim

# Ruby
RUN apt-get -yq update && apt-get -yq install \
  git-core \
  curl \
  zlib1g-dev \
  build-essential \
  libssl-dev \
  libreadline-dev \
  libyaml-dev \
  libxml2-dev \
  libxslt1-dev \
  libcurl4-openssl-dev \
  software-properties-common \
  libffi-dev

RUN git clone https://github.com/sstephenson/ruby-build.git
WORKDIR ruby-build
RUN ./install.sh

ARG RUBY_VERSION
ARG RACK_ENV=production

ENV RUBY_VERSION=$RUBY_VERSION
ENV RACK_ENV=$RACK_ENV

ENV CONFIGURE_OPTS --disable-install-rdoc
RUN ruby-build ${RUBY_VERSION} /usr/local

# Tidy up
RUN apt-get purge -yq curl git-core
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /tmp/sockets

ENV GEM_HOME /var/echo/bundle
ENV PATH $GEM_HOME/bin:$PATH

RUN useradd -ms /bin/bash echouser
RUN mkdir -p /var/echo/bundle
RUN mkdir -p /opt/echo
WORKDIR /opt/echo

# Move over gemfile and install first
# so that we can cache installed gems after a code change
COPY Gemfile /opt/echo
COPY Gemfile.lock /opt/echo

RUN chown -R echouser /opt/echo
RUN chown -R echouser /var/echo

USER echouser
RUN gem install bundler
RUN bundle install --binstubs --without development test

# Now bring in the rest of the code
USER root

COPY . /opt/echo
RUN chown -R echouser /opt/echo

USER echouser

EXPOSE 9292

CMD bundle exec rackup
