# == Schema Information
#
# Table name: permissions
#
#  id         :integer          not null, primary key
#  role_id    :integer          not null
#  entity     :string           not null
#  settings   :hstore
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#

class Permission < ActiveRecord::Base
  acts_as_paranoid

  # 1. associations
  belongs_to :role

  # 2. scopes

  # 3. class methods

  # 4. validates
  validates :entity, presence: true
  validates :settings, presence: true

  # 5. callbacks

  # 6. instance methods
end
