class Item::Press < Item
  store_accessor :data, :timeline, :description
  has_one :item_picture, dependent: :destroy, foreign_key: :item_id

  validates :item_picture, :timeline, :description, presence: true
  accepts_nested_attributes_for :item_picture , reject_if: proc { |attributes| attributes['image'].blank? }

  class << self
    def display_all
      self.all
    end
  end
end
