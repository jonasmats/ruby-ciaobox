# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#

class Role < ActiveRecord::Base
  acts_as_paranoid
  ALL_ENTITY = %w(Admin User Article Faq Faq::Category SocialNetwork)

  # 1. associations
  has_many :permissions, dependent: :destroy
  accepts_nested_attributes_for :permissions, allow_destroy: true
  has_many :users_roles, class_name: CiaoboxUser::UsersRole.name, foreign_key: :role_id
  has_many :admins, through: :users_roles

  # 2. scopes

  # 3. class methods

  # 4. validates
  validates :name, presence: true, uniqueness: true

  # 5. callbacks

  # 6. instance methods
end
