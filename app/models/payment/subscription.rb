class Payment::Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  has_many :payment_invoices, :class_name => 'Payment::Invoice', foreign_key: :payment_subscription_id, dependent: :destroy
end
