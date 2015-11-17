# == Schema Information
#
# Table name: admins
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  type                   :string
#

class CiaoboxUser::Employee < Admin
  include ::CiaoboxUser::Associations

  # 1. associations
  has_many :users_roles, class_name: CiaoboxUser::UsersRole.name, foreign_key: :admin_id
  has_many :roles, through: :users_roles, class_name: Role.name

  # 2. scopes

  # 3. class methods

  # 4. validates

  # 5. callbacks

  # 6. instance methods
end
