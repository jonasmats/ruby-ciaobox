module CiaoboxUser::Associations
  extend ActiveSupport::Concern
  included do
    has_many :articles, class_name: ::Article.name, foreign_key: :admin_id
    has_one :profile, class_name: ::CiaoboxUser::Profile.name, foreign_key: :admin_id, dependent: :destroy
    accepts_nested_attributes_for :profile
    has_many :users_roles, class_name: CiaoboxUser::UsersRole.name, foreign_key: :admin_id
    has_many :roles, through: :users_roles

    has_many :log_actions,  foreign_key: :owner_id
  end
end
