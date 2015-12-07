config = YAML.load_file Rails.root.join('db/data/order_item/bin.yml')
path_image = Rails.public_path.join("master/order_items/bin/")

ActiveRecord::Base.transaction do
  puts "Seed db for Bin OrderItem"
  config.each do |attr|
    id = attr.delete('id')
    bin = OrderItem::Bin.find_by_id id
    unless bin
      bin = OrderItem::Bin.new(attr["data"])
      bin.avatar = File.new("#{path_image}#{attr['avatar']['file']}")
      bin.save!
    end
  end
end
