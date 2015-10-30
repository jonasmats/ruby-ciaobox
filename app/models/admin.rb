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

class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  
  enum status: { un_active: 0, active: 1 }
  delegate :full_name, to: :profile

  #1. associations
  has_one :profile, class_name: CiaoboxUser::Profile.name, foreign_key: :admin_id
  # 2. scope
  scope :super_admin, -> {where(type: CiaoboxUser::Super.name)}
  scope :company_admin, -> {where(type: CiaoboxUser::Company.name)}
  scope :employee_admins, -> {where(type: CiaoboxUser::Employee.name)}

  scope :latest, -> {order("created_at DESC")}
  # 6. instance methods

  def super?
    self.type == CiaoboxUser::Super.name
  end

  def company?
    self.type == CiaoboxUser::Company.name
  end

  def employee?
    self.type == CiaoboxUser::Employee.name
  end

end
