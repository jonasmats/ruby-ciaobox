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

class Faq < ActiveRecord::Base
  acts_as_paranoid
  translates :question, :answer, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations

  # 1. associations
  belongs_to :faq_category, class_name: Faq::Category.name
  # 2. scopes
  default_scope -> { includes(:translations) }
  # 3. class methods

  # 4. validates
  validates :faq_category, :question, :answer, presence: true

  # 5. callbacks

  # 6. instance methods
end
