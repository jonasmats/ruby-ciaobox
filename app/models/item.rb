class Item < ActiveRecord::Base
  scope :members, -> { where(type: 'Item::Member')}
  scope :presses, -> { where(type: 'Item::Press')}
  scope :prices, -> { where(type: 'Item::Price')}
  scope :privacies, -> { where(type: 'Item::Privacy')}
  scope :keypoints, -> { where(type: 'Item::KeyPoint')}
  scope :keypoints, -> { where(type: 'Item::About')}
  scope :howitworks, -> { where(type: 'Item::HowItWork')}

  class << self
    def types
      %w(Item::Member Item::Press Item::Price Item::Privacy Item::KeyPoint Item::About Item::HowItWork)
    end
  end
end
