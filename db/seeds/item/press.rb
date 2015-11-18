name = 'press'
config = YAML.load_file Rails.root.join("db/data/item/#{name}.yml")
path_image = Rails.public_path.join("master/items/#{name.pluralize}/")
type = 'Item::Press'
class_name = type.constantize

ActiveRecord::Base.transaction do
  puts "Seed db for item/#{name}"
  config.each do |attr|
    id = attr["#{name}"].delete('id')
    member = class_name.find_by(id: id, type: type)
    unless member
      member = class_name.new(attr["#{name}"])
      member.build_item_picture
      member.item_picture.image = File.new("#{path_image}#{attr['picture']['file']}")
      member.save!
    end
  end
end