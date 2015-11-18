class V1::NotificationController < V1::BaseController

  def create
    if params[:ids].present?
      params[:ids].split().each do |id|
        Notification.update(id, status: Notification.statuses.keys[1])
      end
      render json: {code: 100, data: "Update status for notification successfully"}
    else
      render json: {code: 300, data: "Missing params ids"}
    end
  end
end
