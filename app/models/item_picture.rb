class ItemPicture < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "300x300>", thumb: "200x200>" }, url: "/images/:class/:attachment/:basename-:hash.:extension",
    hash_secret: "@Picture@"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
