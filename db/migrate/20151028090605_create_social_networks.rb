class CreateSocialNetworks < ActiveRecord::Migration
  def change
    create_table :social_networks do |t|
      t.string :name, null: false
      t.string :link, null: false
      t.attachment :icon
      t.boolean :is_external_link, default: true, null: false
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
