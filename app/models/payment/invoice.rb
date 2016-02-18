class Payment::Invoice < ActiveRecord::Base
  belongs_to :payment_subscription, :class_name => 'Payment::Subscription'
end
