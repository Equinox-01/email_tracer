class EmailHandler
  def send(recipient_email)
    token = TokenGenerator.generate(recipient_email)
    body = <<-HTML
      <html>
        <body>
          <p>Body of the email</p>
          <img src="http://#{ENV['REMOTE_SERVER_IP']}:4567/img.png?token=#{token}">
        </body>
      </html>
    HTML

    mail = Mail.new do
      from     ENV['GMAIL_USERNAME']
      to       recipient_email
      subject  'Subject of the email'
      html_part do
        content_type 'text/html; charset=UTF-8'
        body body
      end
    end

    mail.deliver!
    $logger.info "Email sent to #{recipient_email} with token #{token}"
  end
end