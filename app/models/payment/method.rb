# == Schema Information
#
# Table name: payment_methods
#
#  id           :integer          not null, primary key
#  payment_type :integer
#  name         :string
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Payment::Method < ActiveRecord::Base
  enum payment_type: { online: 0, offline: 1 }

  # 1. associations
  has_many :payment_infors
  # 2. scopes

  # 3. class methods

  # 4. validates
  validates :payment_type, presence: true
  validates :name, presence: true, uniqueness: { scope: :payment_type }

  # 5. callbacks

  # 6. instance methods
end
