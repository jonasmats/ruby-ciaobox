class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :user, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
