FROM ruby:2.6-buster
WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install

COPY . .
EXPOSE 4000
CMD ["bundle", "exec", "rackup","--host", "0.0.0.0", "-p", "4000"]