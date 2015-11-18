module NotificationHelper
  def show notification
    name = notification.info["username"].present? ? notification.info["username"] : notification.info["email"]
    case notification.type
      when Notification::UserRegister.name
        "#{name} #{I18n.t('admins.notification.user_register')}"
      when Notification::ScheduleCreate.name
        "#{name} #{I18n.t('admins.notification.schedule_create')}"
    end
  end
end
