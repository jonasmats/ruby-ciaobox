class AddColumnToTable < ActiveRecord::Migration
  def change
    add_column :user_profiles, :preferred_language, :integer, default: 0
  end
end
