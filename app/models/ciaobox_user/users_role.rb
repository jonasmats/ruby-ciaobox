# == Schema Information
#
# Table name: ciaobox_user_users_roles
#
#  id         :integer          not null, primary key
#  admin_id   :integer
#  role_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CiaoboxUser::UsersRole < ActiveRecord::Base
  belongs_to :admin
  belongs_to :role
end
