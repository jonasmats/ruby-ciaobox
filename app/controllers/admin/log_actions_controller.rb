class Admin::LogActionsController < Admin::BaseAdminController
  before_action :load_log_action, only: :show
  def index
    @log_actions = LogAction.all
  end

  def show
  end

  private
    def load_log_action
      @log_action = LogAction.find(params[:id])
    end
end
