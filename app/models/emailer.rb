#encoding:utf-8
require 'rubygems'
require 'action_mailer'
class Emailer < ActionMailer::Base
  def test_email(email_address, email_body)
    @mail_body = email_body
    mail(:subject => "This is a test e-mail",
         :to => email_address,
         :from => 'ncstrong@gmail.com'
    )
  end
end

