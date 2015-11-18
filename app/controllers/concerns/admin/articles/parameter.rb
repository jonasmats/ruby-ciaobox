module Admin::Articles::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:article]
        params.require(:article).permit(:cover, :status, translations_attributes: [:id, :locale, :title, :description, :content])
      end
    end
end
