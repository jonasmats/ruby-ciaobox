class Driver < ActiveRecord::Base
  #1. associations
  has_many :shippings
  has_many :date_offs, as: :subject
  # 4. validates
  validates :code, :name, presence: true
  validates :code, uniqueness: true
end
