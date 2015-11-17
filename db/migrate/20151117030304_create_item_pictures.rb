class CreateItemPictures < ActiveRecord::Migration
  def change
    create_table :item_pictures do |t|
      t.attachment :image
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
