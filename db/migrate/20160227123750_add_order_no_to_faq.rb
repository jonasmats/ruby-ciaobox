class AddOrderNoToFaq < ActiveRecord::Migration
  def change
    add_column :faqs, :order_no, :integer
  end
end
