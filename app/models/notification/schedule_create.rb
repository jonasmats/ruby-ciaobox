class Notification::ScheduleCreate < Notification
  belongs_to :user, class_name: User.name
end