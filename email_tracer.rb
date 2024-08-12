require 'mail'
require 'sinatra'
require 'logger'
require 'dotenv'

Dotenv.load

set :bind, '0.0.0.0'
set :port, 4567

before do
  logger = Logger.new(STDOUT)
  logger.info "Request from IP: #{request.ip}"
  logger.info "User Agent: #{request.user_agent}"
  logger.info "Referer: #{request.referer}"
  logger.info "Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
  logger.info "Date and Time: #{Time.now}"
end

get '/img.png' do
  content_type 'image/png'
  send_file 'img.png'
end

options = {
  address:              'postfix',
  port:                 25,
  domain:               'example.com',
  authentication:       nil,
  enable_starttls_auto: false
}

Mail.defaults do
  delivery_method :smtp, options
end

sender_email = ENV['SENDER_EMAIL']
recipient_email = ENV['RECIPIENT_EMAIL']
subject = 'Subject of the email'
body = 'Body of the email'

image_path = 'img.png'
image_name = File.basename(image_path)

mail = Mail.new do
  from     sender_email
  to       recipient_email
  subject  subject
  body     body
  add_file filename: image_name, content: File.read(image_path)
end

mail.deliver!
