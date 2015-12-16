class DateOff < ActiveRecord::Base
  belongs_to :subject, polymorphic: true

  validates :start_at, :end_at, :date_off_type, presence: true

  enum date_off_type: { comapny: 0, driver: 1 }
end
