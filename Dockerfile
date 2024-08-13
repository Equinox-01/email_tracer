FROM ruby:latest

WORKDIR /app

COPY Gemfile ./
RUN bundle install

COPY . .

RUN mkdir -p logs

EXPOSE 4567

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]
