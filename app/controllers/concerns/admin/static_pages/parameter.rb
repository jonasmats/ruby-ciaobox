module Admin::StaticPages::Parameter
  extend ActiveSupport::Concern

  private
    def private_params
      if params[:article]
        params.require(:article).permit(:title, :content, :status)
      end
    end
end
