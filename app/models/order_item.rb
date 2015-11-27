class OrderItem < ActiveRecord::Base
  translates :title, :description, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations
  has_one :order_detail
  has_many :order_detail_images
  has_attached_file :avatar, url: "/images/:class/:attachment/:basename-:hash.:extension",
    hash_secret: "@CiaoboxSecretSocialIcont@" # decode with base64
  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ }
end