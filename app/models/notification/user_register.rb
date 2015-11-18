class Notification::UserRegister < Notification
  belongs_to :user, class_name: User.name
end