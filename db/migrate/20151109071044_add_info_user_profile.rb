class AddInfoUserProfile < ActiveRecord::Migration
  def change
    add_column :user_profiles, :telephone, :string
  end
end
