class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :admin, index: true, foreign_key: true

      t.timestamps null: false
    end
    Article.create_translation_table! title: :string, content: :text
  end
end
