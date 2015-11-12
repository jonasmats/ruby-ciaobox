class Admin::Employee::ArticlesController < Admin::ArticlesController
  def create
    if @article.save
      redirect_to admin_employee_article_path(@article), notice: t('notice.admin.created', model: Article.human_name)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.save
      redirect_to admin_employee_article_path(@article), notice: t('notice.admin.updated', model: Article.human_name)
    else
      render :edit
    end
  end

  def destroy
    msg =
      if @article.destroy
        t('notice.admin.admins.destroy.success')
      else
        t('notice.admin.admins.destroy.error')
      end
    redirect_to admin_employee_articles_path, notice: msg
  end
end
