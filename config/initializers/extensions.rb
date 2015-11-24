require "active_record_base.rb"
require "custom_time_format.rb"
require "batch_translation.rb"

$mailchimp = Gibbon::Request.new(api_key: Settings.mailchimp.api_key)
