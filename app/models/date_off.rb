class DateOff < ActiveRecord::Base
  belongs_to :subject, polymorphic: true

  validates :start_at, :end_at, presence: true
end
