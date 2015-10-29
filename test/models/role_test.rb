# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
