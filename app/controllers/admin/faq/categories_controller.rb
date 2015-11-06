class Admin::Faq::CategoriesController < Admin::BaseAdminController
  include Admin::Faqs::Category::Parameter

  before_action :load_instance, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    @categories = ::Faq::Category.all
    # .paginate(page: params[:page], per_page: Settings.per_page.admin.product)
  end

  def new
  end

  def create
    if @category.save
      redirect_to admin_faq_categories_path, notice: t('notice.admin.created', model: Faq::Category.human_name)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.save
      redirect_to admin_faq_categories_path, notice: t('notice.admin.updated', model: Faq::Category.human_name)
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_faq_categories_path, notice: t('notice.admin.deleted', model: Faq::Category.human_name)
  end

  private

  def load_instance
    @category = ::Faq::Category.find(params[:id])
  end

  def create_instance
    @category = ::Faq::Category.new
  end

  def set_params
    @category.assign_attributes private_params
  end
end
