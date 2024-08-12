FROM ruby:latest

RUN gem install mail sinatra dotenv

WORKDIR /app
COPY . .

EXPOSE 4567

CMD ["rackup", "--host", "0.0.0.0"]
