class CreateStaticPages < ActiveRecord::Migration
  def change
    create_table :static_pages do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.integer :status, null: false

      t.timestamps null: false
    end
    add_index :static_pages, :slug, unique: true
    StaticPage.create_translation_table! content: :text
  end
end
