class Driver < ActiveRecord::Base
  #1. associations
  has_many :shippings

  # 4. validates
  validates :code, :name, presence: true
  validates :code, uniqueness: true
end
