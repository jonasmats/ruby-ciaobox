class UserMailer < ApplicationMailer
  default from: "rubydn.com@gmail.com"

  def welcome_email
    #mail(to: "duonghienan.dha@gmail.com", subject: "Welcome to ciaobox!")
    mail(to: "loosenmind@gmail.com", subject: "Welcome to ciaobox!")
  end

  def inquiry_submit_email(name, from, subject, phone, message)
    @email_obj = {
        :name => name,
        :from => from,
        :phone => phone,
        :message => message
    }
    mail(to: "support@ciaobox.ch", subject: subject)
  end
end
