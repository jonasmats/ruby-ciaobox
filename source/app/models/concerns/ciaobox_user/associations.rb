module CiaoboxUser::Associations
  extend ActiveSupport::Concern
  included do
    has_many :articles, class_name: ::Article.name, foreign_key: :admin_id
    has_one :profile, class_name: ::CiaoboxUser::Profile.name, foreign_key: :admin_id
  end
end
