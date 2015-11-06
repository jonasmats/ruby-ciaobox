class Admin::FaqsController < Admin::BaseAdminController
  authorize_resource class: ::Faq.name
  include ::Admin::Faqs::Parameter
  include ::Admin::Faqs::Finder

  before_action :load_instance, only: [:show, :edit, :update, :destroy]
  before_action :create_instance, only: [:new, :create]
  before_action :set_params, only: [:create, :update]

  def index
    @faqs = load_faqs
    # .paginate(page: params[:page], per_page: Settings.per_page.admin.product)
  end

  def new
  end

  def create
    if @faq.save
      redirect_to admin_faqs_path, notice: t('notice.admin.created', model: Faq.name)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @faq.save
      redirect_to admin_faqs_path, notice: t('notice.admin.updated', model: Faq.name)
    else
      render :edit
    end
  end

  def destroy
    @faq.destroy
    redirect_to admin_faqs_path, notice: t('notice.admin.deleted', model: Faq.name)
  end

  private

  def load_instance
    @faq = Faq.find(params[:id])
  end

  def create_instance
    @faq = Faq.new
  end

  def set_params
    @faq.assign_attributes private_params
  end
end
