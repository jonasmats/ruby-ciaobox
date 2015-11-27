config = YAML.load_file Rails.root.join('db/data/order_item/normal.yml')
path_image = Rails.public_path.join("master/order_items/normal/")

ActiveRecord::Base.transaction do
  puts "Seed db for Normal OrderItem"
  config.each do |attr|
    id = attr.delete('id')
    normal = OrderItem::Normal.find_by_id id
    unless normal
      normal = OrderItem::Normal.new(attr["data"])
      normal.avatar = File.new("#{path_image}#{attr['avatar']['file']}")
      normal.save!
    end
  end
end
