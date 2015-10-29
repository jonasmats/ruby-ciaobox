# == Schema Information
#
# Table name: permissions
#
#  id         :integer          not null, primary key
#  role_id    :integer          not null
#  entity     :string           not null
#  settings   :hstore
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class PermissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
