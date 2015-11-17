class Privacy < Item
  store_accessor :data, :heading, :description

  validates :heading, :description, presence: true

  class << self
    def display_all
      self.all
    end
  end
end
