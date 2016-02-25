class Shipping::Schedule::DeliveryController < ScheduleController
  steps :appointment, :review, :confirmation

  include ::Dashboard::Shipping::Schedule::Parameter

  before_action :title_form, only: [:show, :update]
  before_action :check_post_params
  before_action :check_zip_code

  def create
    case step
      when :appointment

      when :review

      when :confirmation
    end
  end

  def show
    case step
      when :appointment
        load_order_detail

        # get address/state
        geocode = Geocoder.coordinates(session[:zip_code])
        result = Geocoder.search(geocode).first
        if result.present?
          @state = result.state
          @address = result.address
        end

      when :review
        if session[:delivery_step].blank? || session[:delivery_step] != 1
          redirect_to shipping_schedule_delivery_path(:appointment) and return
        end
        load_order_detail

      when :confirmation
        if session[:delivery_step].blank?
          redirect_to v1_zip_codes_path and return
        else
          if session[:delivery_step] != 2
            redirect_to shipping_schedule_delivery_path(:appointment) and return
          end
        end
        session.delete(:delivery_step)
    end
    render_wizard
  end

  def update
    case step
      when :review
        logger.debug("UPDATE REVIEW:: #{params.inspect}")
        update_order_detail
        load_order_detail
        session[:delivery_step] = 1

      when :confirmation
        if session[:delivery_step].present? && session[:delivery_step] == 1
          update_order
          update_status
          session[:delivery_step] = 2
        else
          redirect_to shipping_schedule_delivery_path(:appointment) and return
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

  def check_post_params
    #logger.debug("Sessionss:: #{session[:order_detail_ids].inspect}, #{params.inspect}")
    return if session.include?(:order_detail_ids)

    if params[:order_details].present? && params[:order_details][:id].present? && params[:order_details][:id].length > 0
      session[:order_detail_ids] ||= []
      params[:order_details][:id].each do |id|
        session[:order_detail_ids] << id
      end
    else
      redirect_to root_path
    end

  end

  def load_order_detail
    id = session[:order_detail_ids].at(0)
    @order_detail_for_view = OrderDetail.find(id)
    @contact_info = Order.find(@order_detail_for_view[:order_id])
    logger.debug("CONTACT INFO:: #{@contact_info.inspect}")
  end

  def update_order
    current_user.orders.update_all contact_info_params
  end

  def update_order_detail
    #order_details = OrderDetail.find(session[:order_detail_ids])
    order_details = OrderDetail.where("id IN (?)", session[:order_detail_ids])
    order_details.update_all delivery_params
  end

  def update_status
    order_details = OrderDetail.where("id IN (?)", session[:order_detail_ids])
    order_details.update_all(:status => OrderDetail.statuses[:delivery_scheduled])
  end
end