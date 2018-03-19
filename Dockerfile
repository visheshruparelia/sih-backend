FROM ruby:2.4-alpine

RUN apk --update add --virtual\
  build-dependencies build-base libev libev-dev postgresql-dev nodejs bash\
  tzdata sqlite-dev git curl

WORKDIR /app

COPY Gemfile /app/
COPY Gemfile.lock /app/

ENV RAILS_ENV=development
ENV NODE_ENV=development

RUN bundle install --jobs 8

COPY . /app

RUN rake db:setup

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s"]
