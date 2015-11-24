class SubscribeNewslettersJob < ActiveJob::Base
  queue_as :default

  def perform(email)
    $mailchimp.lists(Settings.mailchimp.list_newsletter_id)
      .members.create(body: { email_address: email, status: "subscribed" })
  end
end
