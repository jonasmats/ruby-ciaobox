class OrderDetailImage < ActiveRecord::Base
  belongs_to :order_item
  has_attached_file :image, url: "/images/:class/:attachment/:basename-:hash.:extension",
    hash_secret: "@CiaoboxSecretSocialIcont@" # decode with base64
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ },
    presence: true
end
