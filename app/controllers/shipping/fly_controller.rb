class Shipping::FlyController < ShippingController
  include Wicked::Wizard
  steps :appoinment, :review, :confirmation
end
