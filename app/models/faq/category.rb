# == Schema Information
#
# Table name: faq_categories
#
#  id         :integer          not null, primary key
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Faq::Category < ActiveRecord::Base
  acts_as_paranoid
  translates :name, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations

  # 1. associations
  has_many :faqs, dependent: :destroy, foreign_key: :faq_category_id
  # 2. scopes
  default_scope -> { includes(:translations) }
  scope :order_by_id_desc, -> { order("id DESC") }

  # 3. class methods

  # 4. validates
  validates :name, presence: true

  # 5. callbacks

  # 6. instance methods
end
