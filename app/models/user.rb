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
  acts_as_paranoid
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :async,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2],
         :authentication_keys => [:login]

  attr_accessor :login

  after_create :create_instance_profile, unless: :check_has_param_profile?
  after_create :create_instance_address, unless: :check_has_param_address?
  after_create :create_instance_notification
  after_create :send_notification_for_admin

  delegate :full_name, :avatar, to: :profile, allow_nil: true
  enum status: { un_active: 0, active: 1 }

  # 1. associations
  has_one :profile, class_name: User::Profile.name, foreign_key: :user_id, dependent: :destroy
  has_one :address, class_name: Address.name, foreign_key: :user_id, dependent: :destroy
  has_many :notification, class_name: Notification.name, foreign_key: :user_id, dependent: :destroy
  has_many :user_notification, class_name: Notification::UserRegister.name, foreign_key: :user_id, dependent: :destroy
  has_many :schedule_notification, class_name: Notification::ScheduleCreate.name, foreign_key: :user_id, dependent: :destroy
  has_many :orders
  has_many :order_items
  has_many :feedbacks
  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :address

  has_many :log_actions, as: :subject
  # 2. scopes
  scope :latest, -> {order("created_at DESC")}
  # 4 validates
  validates_format_of :username, with: /\A^[a-zA-Z0-9_\.]*$\z/
  validates :status, presence: true
  # 5
  private
  def create_instance_profile
    self.create_profile
  end

  def check_has_param_profile?
    self.profile.present?
  end

  def create_instance_address
    self.create_address
  end

  #chec has params
  def check_has_param_address?
    self.address.present?
  end

  def create_instance_notification
    info = {username: self.username, email: self.email}
    self.user_notification.create!(info: info)
  end

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

  def send_notification_for_admin
    NotificationMailer.delay.new_user(self).deliver
  end

end
