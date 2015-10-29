# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  admin_id   :integer
#  status     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
