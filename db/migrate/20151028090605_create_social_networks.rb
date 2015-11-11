class CreateSocialNetworks < ActiveRecord::Migration
  def change
    create_table :social_networks do |t|
      t.string :name
      t.string :link
      t.attachment :icon
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
