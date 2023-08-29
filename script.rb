require 'rest-client'
require 'json'

SENDGRID_API_URL = 'https://api.sendgrid.com/v3/mail/send'.freeze
SENDGRID_API_KEY = 'YOUR_SENDGRID_API_KEY'.freeze

# Read the email template from the file
email_html_content = File.read('email_template.html')

# Create the payload for SendGrid
payload = {
  personalizations: [
    {
      to: [{ email: 'recipient@example.com' }],
      subject: 'Hello, World!'
    }
  ],
  from: { email: 'sender@example.com' },
  content: [
    {
      type: 'text/html',
      value: email_html_content
    }
  ]
}.to_json

# Headers for the API call
headers = {
  Authorization: "Bearer #{SENDGRID_API_KEY}",
  Content_Type: 'application/json'
}

# Send the email and handle potential errors
begin
  response = RestClient.post(SENDGRID_API_URL, payload, headers)
  puts response.body
rescue RestClient::ExceptionWithResponse => e
  puts "Error sending email: #{e.response}"
end
