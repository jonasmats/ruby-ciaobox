class AddNoteForUser < ActiveRecord::Migration
  def change
    add_column :users, :note, :hstore
  end
end
