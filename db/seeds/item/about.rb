name = 'about'
config = YAML.load_file Rails.root.join("db/data/item/#{name}.yml")
type = 'Item::About'
class_name = type.constantize

ActiveRecord::Base.transaction do
  puts "Seed db for item/#{name}"
  config.each do |attr|
    id = attr["#{name}"].delete('id')
    about = class_name.find_by(id: id, type: type)
    unless about
      about = class_name.create!(attr["#{name}"])
    end
  end
end

