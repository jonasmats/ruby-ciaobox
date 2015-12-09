class OrderItem < ActiveRecord::Base
  acts_as_paranoid
  translates :title, :description, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations
  belongs_to :user
  has_one :order_detail
  has_many :order_detail_images
  has_attached_file :avatar, url: "/images/:class/:attachment/:basename-:hash.:extension",
    hash_secret: "@CiaoboxSecretSocialIcont@" # decode with base64
  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ }

  scope :bin, -> { where(type: OrderItem::Bin.name) }

  scope :box_and_bin, -> { where(type: [OrderItem::Box.name, OrderItem::Bin.name]) }
  scope :order_bin_box, -> { order(type: :asc) }

  scope :normal_and_other, -> { where(type: [OrderItem::Normal.name, OrderItem::Other.name]) }
  scope :order_normal_other, -> { order(type: :asc) }
end