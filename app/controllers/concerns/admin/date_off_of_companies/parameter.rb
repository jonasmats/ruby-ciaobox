module Admin::DateOffOfCompanies::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      params.require(:date_off).permit(:start_at, :end_at)
    end
end
