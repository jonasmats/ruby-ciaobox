module Admin::Banners::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:banner]
        params.require(:banner).permit(:status, :image)
      end
    end
end
