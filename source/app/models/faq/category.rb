class Faq::Category < ActiveRecord::Base
  acts_as_paranoid
  translates :name, fallbacks_for_empty_translations: true

  # 1. associations
  has_many :faqs, dependent: :destroy, foreign_key: :faq_category_id
  # 2. scopes

  # 3. class methods

  # 4. validates
  validates :name, presence: true

  # 5. callbacks

  # 6. instance methods
end
