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

class Article < ActiveRecord::Base
  # acts_as_paranoid
  translates :title, :content, fallbacks_for_empty_translations: true
  
  enum status: { un_publish: 0, publish: 1 }

  # 1. associations
  belongs_to :admin, class_name: Admin.name
  # 2. scope
  scope :article_status, -> (status)  {where(status: statuses[status])}
  # 4. validates
  validates :admin, :title, :content, presence: true
end
