FROM ruby:2.5.1

WORKDIR /lib

COPY . .
RUN bundle install

CMD ["bundle", "exec", "rspec"]
