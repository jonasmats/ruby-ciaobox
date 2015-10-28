class CreateFaqCategories < ActiveRecord::Migration
  def up
    create_table :faq_categories do |t|
      t.datetime :deleted_at

      t.timestamps null: false
    end
    Faq::Category.create_translation_table! name: :string
  end

  def down
    drop_table :faq_categories
    Faq::Category.drop_translation_table!
  end
end
