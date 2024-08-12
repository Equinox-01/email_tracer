FROM ruby:latest

# Установка зависимостей
RUN gem install mail sinatra

# Копирование кода в Docker образ
WORKDIR /app
COPY . .

# Запуск приложения
CMD ["rackup", "--host", "0.0.0.0"]
