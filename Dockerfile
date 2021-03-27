FROM ruby:2.6.6-alpine

RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache \
    build-base curl-dev git \
    yaml-dev zlib-dev nodejs yarn mariadb-dev \
    apk add alpine-sdk git ruby-full ruby-dev \
    tzdata bash

RUN gem install bundler -v 2.1.4
RUN gem install --no-ri --no-rdoc rubocop 

ENV app /app
RUN mkdir $app
WORKDIR $app

ADD . $app

RUN bundle install --jobs 4 --retry 5

EXPOSE 3189

CMD bundle exec rails s -p 3189
