class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.attachment :image
      t.integer :status, null: false
      t.datetime :deleted_at
      
      t.timestamps null: false
    end
  end
end
