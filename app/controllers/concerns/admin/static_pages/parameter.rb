module Admin::StaticPages::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:static_page]
        params.require(:static_page).permit(:title, :content, :status)
      end
    end
end
