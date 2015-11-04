class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :email, index: true, uniq: true
      t.timestamps null: false
    end
  end
end
