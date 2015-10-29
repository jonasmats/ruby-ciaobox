class Article < ActiveRecord::Base
  # acts_as_paranoid
  translates :title, :content, fallbacks_for_empty_translations: true
  
  enum status: { un_publish: 0, publish: 1 }

  # 1. associations
  belongs_to :admin, class_name: Admin.name
  # 4. validates
  validates :admin, :title, :content, presence: true
end
