# == Schema Information
#
# Table name: ciaobox_user_users_roles
#
#  id         :integer          not null, primary key
#  admin_id   :integer
#  role_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CiaoboxUser::UsersRoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
