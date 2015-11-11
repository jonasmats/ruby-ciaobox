config = YAML.load_file Rails.root.join('db/data/zip_code.yml')

ActiveRecord::Base.transaction do
  puts "Seed db for Shipping"
  config.each do |attr|
    id = attr.delete('id')
    shipping = Shipping.find_by_id id
    if shipping
      shipping.update! attr
    else
      shipping = Shipping.create!(attr)
    end
  end
end
