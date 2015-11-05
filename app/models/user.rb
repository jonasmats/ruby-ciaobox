# == Schema Information
#
# Table name: users
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
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :async,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2],
         :authentication_keys => [:login]

  attr_accessor :login

  delegate :full_name, to: :profile
  enum status: { un_active: 0, active: 1 }

  # 1. associations
  has_one :profile, class_name: User::Profile.name, foreign_key: :user_id
  accepts_nested_attributes_for :profile, allow_destroy: true
  # 2. scopes
  scope :latest, -> {order("created_at DESC")}
  # 4 validates
  validates_format_of :username, with: /\A^[a-zA-Z0-9_\.]*$\z/
  # 6
  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.username
      user.status = User.statuses[:active]
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["username = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end
end
