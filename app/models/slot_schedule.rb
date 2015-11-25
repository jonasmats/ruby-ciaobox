class SlotSchedule < ActiveRecord::Base
  belongs_to :slot_time
  belongs_to :driver

  enum slot_date: { 
    mon: 0, tue: 1, wed: 2, 
    thu: 3, fri: 4, sat: 5, sun: 6
  }

  validates :slot_time, :driver, :limit, :slot_date, presence: true
end
