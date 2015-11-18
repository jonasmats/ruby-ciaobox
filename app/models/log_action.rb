class LogAction < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  belongs_to :admin, foreign_key: :owner_id

  #scope
  scope :latest, -> {order("created_at DESC")}
end
