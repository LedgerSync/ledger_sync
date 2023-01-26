FROM ruby:2.6.6

WORKDIR /lib

COPY . .
RUN gem install bundler
RUN bundle install

CMD ["bundle", "exec", "rspec", "--order rand"]
