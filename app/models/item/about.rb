class Item::About < Item
  store_accessor :data, :content

  validates :content, presence: true

  class << self
    def display_all
      self.all
    end
  end
end
