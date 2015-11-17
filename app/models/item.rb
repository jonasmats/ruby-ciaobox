class Item < ActiveRecord::Base
  scope :members, -> { where(type: 'Member')}
  scope :presses, -> { where(type: 'Press')}
  scope :prices, -> { where(type: 'Price')}
  scope :privacies, -> { where(type: 'Privacy')}
  scope :keypoints, -> { where(type: 'KeyPoint')}

  class << self
    def types
      %w(Item::Member Item::Press Item::Price Item::Privacy Item::KeyPoint)
    end
  end
end
