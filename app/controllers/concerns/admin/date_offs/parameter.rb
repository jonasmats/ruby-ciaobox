module Admin::DateOffs::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      params.require(:date_off).permit(:start_at, :end_at, :date_off_type)
    end
end
