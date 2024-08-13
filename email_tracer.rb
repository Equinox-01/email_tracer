require 'mail'
require 'sinatra'
require 'logger'
require 'dotenv'
require 'redis'

require_relative 'email_handler.rb'
require_relative 'token_generator.rb'

Dotenv.load

set :bind, '0.0.0.0'
set :port, 4567

$redis = Redis.new(url: ENV['REDIS_URL'])

Dir.mkdir("logs") unless Dir.exist?("logs")
log_file = File.new("logs/access.log", "a+")
log_file.sync = true
$logger = Logger.new(log_file)

Mail.defaults do
  delivery_method :smtp, {
    address:              'smtp.gmail.com',
    port:                 587,
    user_name:            ENV['GMAIL_USERNAME'],
    password:             ENV['GMAIL_PASSWORD'],
    authentication:       'plain',
    enable_starttls_auto: true
  }
end

# Routes
get '/img.png' do
  token = params['token'] || halt(401, 'Unauthorized: Token is required')
  email = $redis.get(token)

  $logger.info "---------------------------------------------------------------"
  $logger.info "Image requested"
  $logger.info "Request from IP: #{request.ip}"
  $logger.info "User Agent: #{request.user_agent}"
  $logger.info "Referer: #{request.referer}"
  $logger.info "Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
  $logger.info "Date and Time: #{Time.now}"
  $logger.info "Email: #{email || 'Unknown'}"
  $logger.info "---------------------------------------------------------------"

  content_type 'image/png'
  send_file 'img.png'
end

EmailHandler.new.send(ENV['RECIPIENT_EMAIL'])