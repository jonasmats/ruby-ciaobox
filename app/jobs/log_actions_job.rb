class LogActionsJob < ActiveJob::Base
  queue_as :default

  def perform(params, subject)
    subject.create_log_action(params)
  end
end
