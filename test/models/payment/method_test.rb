# == Schema Information
#
# Table name: payment_methods
#
#  id           :integer          not null, primary key
#  payment_type :integer
#  name         :string
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class Payment::MethodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
