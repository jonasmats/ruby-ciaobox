config = YAML.load_file Rails.root.join('db/data/order_item/other.yml')
path_image = Rails.public_path.join("master/order_items/other/")

ActiveRecord::Base.transaction do
  puts "Seed db for Other OrderItem"
  config.each do |attr|
    id = attr.delete('id')
    other = OrderItem::Other.find_by_id id
    unless other
      other = OrderItem::Other.new(attr["data"])
      other.avatar = File.new("#{path_image}#{attr['avatar']['file']}")
      other.save!
    end
  end
end
