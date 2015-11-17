class Notification < ActiveRecord::Base
  belongs_to :user
  enum status: { open: 0, closed: 1 }
  validates :status, :info, presence: true

  scope :open, -> { where(status: statuses["open"]) }
  scope :closed, -> { where(status: statuses["closed"]) }
  scope :latest, -> {order("created_at DESC")}
end
