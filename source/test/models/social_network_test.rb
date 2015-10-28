# == Schema Information
#
# Table name: social_networks
#
#  id                :integer          not null, primary key
#  link              :string
#  icon_file_name    :string
#  icon_content_type :string
#  icon_file_size    :integer
#  icon_updated_at   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class SocialNetworkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
