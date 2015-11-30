class Gift < ActiveRecord::Base
  translates :name, :description, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations
  has_attached_file :image,
    url: "/images/:class/:attachment/:basename-:hash.:extension",
    hash_secret: "@CiaoboxSecretGiftImage@" # decode with base64

  # 1. associations
  has_many :gifts_coupons
  has_many :custom_gifts, through: :gifts_coupons

  # 2. scopes
  default_scope -> { includes(:translations) }
  # 3. class methods

  # 4. validates
  validates_attachment_content_type :image, presence: true, content_type: /\Aimage\/.*\Z/

  # 5. callbacks

  # 6. instance methods
end
