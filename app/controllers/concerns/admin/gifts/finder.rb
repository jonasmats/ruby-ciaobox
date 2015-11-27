module Admin::Gifts::Finder
  extend ActiveSupport::Concern
  def load_gifts
    Gift.all
  end

  def load_instance
    @gift = Gift.find(params[:id])
  end
end