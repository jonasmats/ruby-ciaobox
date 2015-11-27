config = YAML.load_file Rails.root.join('db/data/order_item/box.yml')
path_image = Rails.public_path.join("master/order_items/box/")

ActiveRecord::Base.transaction do
  puts "Seed db for Box OrderItem"
  config.each do |attr|
    id = attr.delete('id')
    box = OrderItem::Box.find_by_id id
    unless box
      box = OrderItem::Box.new(attr["data"])
      box.avatar = File.new("#{path_image}#{attr['avatar']['file']}")
      box.save!
    end
  end
end
