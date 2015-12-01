module Admin::Gifts::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:gift]
        params.require(:gift).permit(:image, translations_attributes: [:id, :locale, :name, :description])
      end
    end
end
