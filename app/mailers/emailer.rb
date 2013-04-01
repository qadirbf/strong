#encoding:utf-8
require 'rubygems'
require 'action_mailer'
class Emailer < ActionMailer::Base
  def test_email(email_address, email_body)
    recipients(email_address)
    from "ncstrong@gmail.com"
    subject "This is a test e-mail"
    body email_body
  end
end

