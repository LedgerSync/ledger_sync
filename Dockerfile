FROM ruby:2.6.6

WORKDIR /lib

COPY . .
RUN bundle install

CMD ["bundle", "exec", "rspec"]
