class ApplicationMailer < ActionMailer::Base
  default to: "info@manageme.com", from: "info@manageme.com"
  layout 'mailer'
end
