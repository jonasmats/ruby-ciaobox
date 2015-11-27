class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.attachment :image

      t.timestamps null: false
    end
    Gift.create_translation_table! name: :string, description: :text
  end
end
