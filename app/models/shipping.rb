class Shipping < ActiveRecord::Base
  
  # enum ways: [ :standard, :fly]
  enum way: { standard: 0, fly: 1 }

  #1. associations
  belongs_to :driver

  # 4. validates
  validates :zip_code, :driver, presence: true
  # validates :way, inclusion: { in: ways }
end
