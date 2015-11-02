# == Schema Information
#
# Table name: payment_infors
#
#  id                :integer          not null, primary key
#  owner_id          :integer          not null
#  owner_type        :string           not null
#  payment_method_id :integer          not null
#  infors            :hstore           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class Payment::InforTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
