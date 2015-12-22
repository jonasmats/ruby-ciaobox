class NotificationMailer < ApplicationMailer
  default from: "rubydn.com@gmail.com"

  def new_user(user)
    @user = user
    mail(to: CiaoboxUser::Super.first.email, subject: "[ciaobox] Have new user")
  end
end
