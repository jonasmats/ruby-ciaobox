class Item::KeyPoint < Item
  store_accessor :data, :description

  validates :description, presence: true

  class << self
    def display_all
      self.all
    end
  end
end
