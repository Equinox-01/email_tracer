require 'mail'
require 'sinatra'
require 'logger'
require 'dotenv'
require 'base64'

Dotenv.load

set :bind, '0.0.0.0'
set :port, 4567

Dir.mkdir("logs") unless Dir.exist?("logs")

log_file = File.new("logs/access.log", "a+")
log_file.sync = true
logger = Logger.new(log_file)

get '/img.png' do
  logger.info "---------------------------------------------------------------"
  logger.info "Image requested"
  logger.info "Request from IP: #{request.ip}"
  logger.info "User Agent: #{request.user_agent}"
  logger.info "Referer: #{request.referer}"
  logger.info "Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
  logger.info "Date and Time: #{Time.now}"
  logger.info "---------------------------------------------------------------"

  content_type 'image/png'
  send_file 'img.png'
end

options = {
  address:              'smtp.gmail.com',
  port:                 587,
  user_name:            ENV['GMAIL_USERNAME'],
  password:             ENV['GMAIL_PASSWORD'],
  authentication:       'plain',
  enable_starttls_auto: true
}

Mail.defaults do
  delivery_method :smtp, options
end

sender_email = ENV['GMAIL_USERNAME']
recipient_email = ENV['RECIPIENT_EMAIL']
subject = 'Subject of the email'
body = "<html><body><p>Body of the email</p><img src=\"http://#{ENV['REMOTE_SERVER_IP']}:4567/img.png\"></body></html>"

mail = Mail.new do
  from     sender_email
  to       recipient_email
  subject  subject
  html_part do
    content_type 'text/html; charset=UTF-8'
    body body
  end
end

mail.deliver!

logger.info "Email sent to #{recipient_email}"
