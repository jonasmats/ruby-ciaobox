class SlotTime < ActiveRecord::Base
  has_many :slot_times, dependent: :destroy

  validates :start_at, :end_at, presence: true
end
