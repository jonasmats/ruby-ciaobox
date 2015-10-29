module Admin::Roles::Finder
  extend ActiveSupport::Concern
  def load_roles
    ::Role.all
  end
end