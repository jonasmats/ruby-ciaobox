# == Schema Information
#
# Table name: social_networks
#
#  id                :integer          not null, primary key
#  link              :string
#  icon_file_name    :string
#  icon_content_type :string
#  icon_file_size    :integer
#  icon_updated_at   :datetime
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class SocialNetwork < ActiveRecord::Base
  acts_as_paranoid

  # 1. associations

  # 2. scopes

  # 3. class methods

  # 4. validates
  validates :link, presence: true
  has_attached_file :icon, url: "/images/:class/:attachment/:basename-:hash.:extension",
    hash_secret: "@CiaoboxSecretSocialIcont@" # decode with base64
  validates_attachment :icon, content_type: { content_type: /\Aimage\/.*\Z/ },
    presence: true

  # 5. callbacks

  # 6. instance methods
end
