class Shipping::FlyController < ApplicationController
  include Wicked::Wizard
  steps :appoinment, :review, :confirmation
end
