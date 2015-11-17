module Admin::Articles::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:article]
        params.require(:article).permit(:cover, :title, :description, :content, :status)
      end
    end
end
