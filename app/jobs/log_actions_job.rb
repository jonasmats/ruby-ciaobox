class LogActionsJob < ActiveJob::Base
  queue_as :default

  def perform(params, subject)
    subject.log_actions.create(params)
  end
end
