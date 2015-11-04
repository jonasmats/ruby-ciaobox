class Newsletter < ActiveRecord::Base
  # 4. validates
  validates :email, presence: true
end
