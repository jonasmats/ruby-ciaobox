class Admin::BaseAdminController < ApplicationController
  before_action :authenticate_admin!
  layout 'empty'
end
