# == Schema Information
#
# Table name: static_pages
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  slug       :string           not null
#  status     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class StaticPageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
