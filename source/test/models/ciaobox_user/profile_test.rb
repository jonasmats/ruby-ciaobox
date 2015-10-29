# == Schema Information
#
# Table name: ciaobox_user_profiles
#
#  id                  :integer          not null, primary key
#  admin_id            :integer
#  first_name          :string
#  last_name           :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

require 'test_helper'

class CiaoboxUser::ProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
