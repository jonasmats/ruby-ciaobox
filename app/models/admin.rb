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
  :recoverable, :rememberable, :trackable, :validatable,
  :async,
  :authentication_keys => [:login]

  after_create :create_instance_profile

  attr_accessor :login

  enum status: { un_active: 0, active: 1 }
  delegate :full_name, to: :profile

  #1. associations
  has_one :profile, class_name: ::CiaoboxUser::Profile.name, foreign_key: :admin_id
  # 2. scope
  scope :super_admin, -> { where(type: CiaoboxUser::Super.name) }
  scope :company_admin, -> { where(type: CiaoboxUser::Company.name) }
  scope :employee_admins, -> { where(type: CiaoboxUser::Employee.name) }

  scope :load_admins_for_manager_admin, -> (type) do
   case type
    when CiaoboxUser::Super.name
      self.all
    when CiaoboxUser::Company.name
      self.where(type: [CiaoboxUser::Company.name, CiaoboxUser::Employee.name])
    when CiaoboxUser::Employee.name
      self.employee_admins
    end
  end

  scope :latest, -> {order("created_at DESC")}

  #3. class methods
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["username = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end

  # 4 validates
  validates_format_of :username, with: /\A^[a-zA-Z0-9_\.]*$\z/
  # 5
  
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

  private
  def create_instance_profile
    self.create_profile
  end
end
