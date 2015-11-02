class UserMailer < ApplicationMailer
  default from: "rubydn.com@gmail.com"

  def welcome_email
    mail(to: "duonghienan.dha@gmail.com", subject: "Welcome to ciaobox!")
  end
end
