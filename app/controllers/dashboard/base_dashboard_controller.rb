class Dashboard::BaseDashboardController < ApplicationController
  layout 'application.dashboard'
  before_action :authenticate_user!
end
