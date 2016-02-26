class AddIsExternalLinkToSocialNetwork < ActiveRecord::Migration
  def change
    add_column :social_networks, :is_external_link, :boolean
  end
end
