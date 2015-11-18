class Item::Price < Item
  store_accessor :data, :heading, :money, :description
  has_one :item_picture, dependent: :destroy, foreign_key: :item_id

  validates :item_picture, :heading, :money, :description, presence: true
  accepts_nested_attributes_for :item_picture , reject_if: proc { |attributes| attributes['image'].blank? }

  class << self
    def display_all
      self.includes(:item_picture).all
    end
  end
end
