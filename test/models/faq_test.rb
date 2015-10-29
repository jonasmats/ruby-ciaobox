# == Schema Information
#
# Table name: faqs
#
#  id              :integer          not null, primary key
#  faq_category_id :integer
#  deleted_at      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class FaqTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
