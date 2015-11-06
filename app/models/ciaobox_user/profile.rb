# == Schema Information
#
# Table name: ciaobox_user_profiles
#
#  id                  :integer          not null, primary key
#  admin_id            :integer
#  first_name          :string
#  last_name           :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

class CiaoboxUser::Profile < ActiveRecord::Base
  has_attached_file :avatar, 
    styles: { medium: "300x300>", thumb: "100x100>" }, 
    default_url: "/images/:style/missing.png",
    url: "/images/:class/:attachment/:basename-:hash.:extension",
    hash_secret: "@CiaoboxSecretSocialIcont@" # decode with base64

  # 1. associations
  belongs_to :admin
  # 2. scopes

  # 3. class methods
  def self.table_name_prefix
    'ciaobox_user_'
  end
  # 4. validates
  validates :first_name, :last_name, presence: true, on: :update
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/, 
    presence: true, on: :update

  # 5. callbacks

  # 6. instance methods
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
