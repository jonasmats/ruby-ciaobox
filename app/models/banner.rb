# == Schema Information
#
# Table name: banners
#
#  id                 :integer          not null, primary key
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  status             :integer          not null
#  deleted_at         :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Banner < ActiveRecord::Base
  acts_as_paranoid
  enum status: { un_publish: 0, publish: 1 }

  has_attached_file :image, url: "/images/:class/:attachment/:basename-:hash.:extension",
    hash_secret: "@CiaoboxSecretSocialIcont@" # decode with base64
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ },
    presence: true
  validates :status, presence: true

  def self.current_home_banner
    where(status: 1).first
  end
end
