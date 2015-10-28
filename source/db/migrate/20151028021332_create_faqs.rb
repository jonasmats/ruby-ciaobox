class CreateFaqs < ActiveRecord::Migration
  def up
    create_table :faqs do |t|
      t.references :faq_category, index: true, foreign_key: true
      t.datetime :deleted_at

      t.timestamps null: false
    end
    Faq.create_translation_table! question: :text, answer: :text
  end

  def down
    drop_table :faqs
    Faq.drop_translation_table!
  end
end
