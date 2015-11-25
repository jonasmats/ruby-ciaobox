class DateOff < ActiveRecord::Base
  validates :start_at, :end_at, presence: true
end
