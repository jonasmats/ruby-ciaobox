class Faq < ActiveRecord::Base
  acts_as_paranoid
  translates :question, :answer

  belongs_to :faq_category, class_name: Faq::Category.name
end
