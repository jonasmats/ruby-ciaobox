require 'exception_notification/rails'

ExceptionNotification.configure do |config|
  # not notify development, test env
  config.ignore_if do
    Rails.env.development? || Rails.env.test?
  end

  # Slack
  config.add_notifier :slack, {
    webhook_url: Settings.slack.webhook_url,
    username: "[#{Rails.env.capitalize}] Exception Notification",
    additional_parameters: {
      icon_emoji: ':imp:'
    }
  }
end
