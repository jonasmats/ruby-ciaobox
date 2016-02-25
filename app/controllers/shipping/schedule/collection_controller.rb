class Shipping::Schedule::CollectionController < ScheduleController
  steps :appointment, :review, :confirmation

  include ::Dashboard::Shipping::Schedule::Parameter

  before_action :check_order_info, only: [:show, :update]
  before_action :title_form, only: [:show, :update]

  def show
    case step
      when :appointment

      when :review
        if session[:collection_step].blank? || session[:collection_step] != 1
          redirect_to v1_zip_codes_path and return
        end

      when :confirmation
        if session[:collection_step].blank?
          redirect_to v1_zip_codes_path and return
        else
          if session[:collection_step] != 2
            redirect_to shipping_schedule_collection_path(:appointment) and return
          end
        end
        session.delete(:collection_step)
    end
    render_wizard
  end

  def update
    case step
      when :review
        update_instance
        session[:collection_step] = 1

      when :confirmation
        if session[:collection_step].present? && session[:collection_step] == 1
          update_instance
          update_status
          session[:collection_step] = 2
        else
          redirect_to shipping_schedule_collection_path(:appointment) and return
        end
    end
    render_wizard
  end

  private
  def title_form
    @title =
      case step
        when :appointment
          "When should we swing by?"
        when :review
          "Confirm Your Details"
        when :confirmation
          "Confirmation"
      end
  end

  def update_instance
    if current_user.orders.upcoming.present?
      current_user.orders.upcoming.update_all private_params
    end

    if current_user.orders.pickup_scheduled.present?
      current_user.orders.pickup_scheduled.update_all private_params
    end
    #logger.debug("Update Instance:: #{private_params.inspect}")
  end

  def update_status
    if current_user.orders.upcoming.present?
      current_user.orders.upcoming.update_all(:status => Order.statuses[:pickup_scheduled])
    end
  end

  def check_order_info
    if current_user.orders.upcoming.present? || current_user.orders.pickup_scheduled.present?
      @order_for_view = current_user.orders.upcoming[0] if current_user.orders.upcoming.present?
      @order_for_view = current_user.orders.pickup_scheduled[0] if @order_for_view.nil?
    else
      redirect_to v1_zip_codes_path and return
    end
    #logger.debug("ORDER FOR VIEW:: #{@order_for_view.inspect}, #{current_user.orders.upcoming[0].inspect}")
  end

  def check_order_info?
    current_user.orders.upcoming.present? || current_user.orders.pickup_scheduled.present?
  end
end