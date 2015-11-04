class Shipping < ActiveRecord::Base
  
  enum ways: [ :standard, :fly]

  # 4. validates
  validates :zip_code, presence: true
  validates :way, inclusion: { in: ways }
end
