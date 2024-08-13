 # Email Tracker Application

 This project is a simple Sinatra application that sends emails with embedded images for tracking purposes. The application uses Redis to track email opens by associating unique tokens with recipient emails. The project also includes Docker support for easy deployment.

 ## Project Structure

 `Dockerfile`: Docker configuration for building the Ruby application.
 
 `docker-compose.yml`: Docker Compose configuration for running the application and Redis service.
 
 `email_handler.rb`: Contains the EmailHandler class for sending emails.
 
 `email_tracer.rb`: Main Sinatra application file.

 `Gemfile`: Ruby gem dependencies.

 `logs/`: Directory for log files.

 `img.png`: Image to be embedded in emails.

 ## Prerequisites

 Before running the application, ensure you have the following:

 - Docker and Docker Compose installed
 - A Gmail account for sending emails

 ## Setup

 1. Create a .env file in the root directory with the following environment variables:

 ```env  
GMAIL_USERNAME=your_gmail_username  
GMAIL_PASSWORD=your_gmail_password 
RECIPIENT_EMAIL=recipient_email@example.com  
REMOTE_SERVER_IP=your_server_ip 
 ```
 2. Build and run the application using Docker Compose:

 ```bash  
 docker-compose up --build 
 ```

 ## Usage

 The application will start on port 4567. It will automatically send an email with an embedded image to the recipient specified in the .env file. The image URL will include a unique token for tracking.

 - Email Handling: The EmailHandler class is responsible for sending emails with a unique token attached to the image URL.
 - Image Tracking: When the image is requested, the application logs details such as IP address, user agent, and referer.

 ## Logging

 Log files will be stored in the logs/ directory. The following details are logged when the image is requested:

 - Request IP
 - User Agent
 - Referer
 - Accept-Language
 - Date and Time
 - Recipient Email

 ## Configuration

 - Redis: Used for storing tokens and associated email addresses. The Redis service is configured in docker-compose.yml.
 - SMTP: Gmail SMTP settings are configured in email_tracer.rb for sending emails.

 ## Troubleshooting

 - Ensure that your Gmail credentials and recipient email are correctly set in the .env file.
 - Check the Docker logs for any errors related to the application or Redis.
 - For gmail use only app passwords !
