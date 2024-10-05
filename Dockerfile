FROM ruby:2.7.3-alpine

RUN apk add --no-cache build-base sqlite sqlite-dev sqlite-libs tzdata

ENV BUNDLE_PATH /bundle

WORKDIR /app

ADD Gemfile Gemfile.lock ./
RUN bundle install

ADD . .

CMD ["ruby", "questionnaire.rb"]