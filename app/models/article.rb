# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  admin_id   :integer
#  status     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ActiveRecord::Base
  # acts_as_paranoid
  translates :title, :description, :content, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations

  enum status: { un_publish: 0, publish: 1 }
  has_attached_file :cover,
    default_url: "blog_cover_default.png",
    url: "/images/:class/:attachment/:basename-:hash.:extension",
    hash_secret: "@CiaoboxSecretSocialcoverblog@" # decode with base64

  # 1. associations
  belongs_to :admin, class_name: Admin.name
  # 2. scope
  scope :article_status, -> (status)  {where(status: statuses[status])}
  scope :live, ->{ where status: statuses[:publish] }

  delegate :full_name, :avatar, to: :admin, prefix: true
  # 4. validates
  validates :admin, :title, :description, :content, :status, presence: true
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/
end
