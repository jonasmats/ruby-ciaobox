class Admin::ItemsController < Admin::BaseAdminController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_type, :view_path

  def index
    @items = load_items
  end

  def show
  end

  def new
    @item = type_class.new
  end

  def edit
  end

  def create
    @item = type_class.new(item_params)

    if @item.save
      redirect_to polymorphic_url([:admin, @item]), notice: "#{type} was successfully created."
    else
      render action: 'new'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to polymorphic_url([:admin, @item]), notice: "#{type} was successfully created."
    else
      render action: 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to polymorphic_url([:admin, @item])
  end

  private
    def set_type
      @type = type
    end

    def type
      Item.types.include?(params[:type]) ? params[:type] : "Item"
    end

    def type_class
      type.constantize
    end

    def set_item
      @item = type_class.find(params[:id])
    end

    def item_params
      params.require(type.underscore.gsub('/','_').to_sym).permit(data: type.constantize.stored_attributes[:data], item_picture_attributes: [:image])
    end

    def load_items
      if ['Item::Member'].include?(@type)
        type_class.includes(:item_picture).all
      else
        type_class.all
      end
    end

    def view_path
      @view_path = "/admin/items/#{@type.underscore.gsub('item/', '')}"
    end
end
