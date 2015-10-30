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

class StaticPage < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  translates :content, fallbacks_for_empty_translations: true

  enum status: { un_publish: 0, publish: 1 }

  # 2. scope
  scope :static_page_status, -> (status)  {where(status: statuses[status])}
  # 4. validates
  validates :title, :content, presence: true
end
