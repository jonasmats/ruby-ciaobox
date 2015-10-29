class Banner < ActiveRecord::Base
  acts_as_paranoid
  enum status: { un_publish: 0, publish: 1 }

  has_attached_file :image, url: "/images/:class/:attachment/:basename-:hash.:extension",
    hash_secret: "@CiaoboxSecretSocialIcont@" # decode with base64
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ },
    presence: true
  validates :status, presence: true
end
