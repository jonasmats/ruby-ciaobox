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
  validates :name, :link, presence: true
  has_attached_file :icon, styles: { thumb: '32x32#', small: "64x64#", medium: '128x128#' },
    default_url: "assets/images/facebook-icon.png",
    url: "/images/:class/:attachment/:basename-:hash.:extension",
    hash_secret: "@CiaoboxSecretSocialIcont@" # decode with base64
  validates_attachment :icon, content_type: { content_type: /\Aimage\/.*\Z/ }

  # 5. callbacks

  # 6. instance methods
end
