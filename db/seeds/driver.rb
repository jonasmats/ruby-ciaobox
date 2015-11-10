config = YAML.load_file Rails.root.join('db/data/driver.yml')

ActiveRecord::Base.transaction do
  puts "Seed db for Driver"
  config.each do |attr|
    id = attr.delete('id')
    driver = Driver.find_by_id id
    if driver
      driver.update! attr
    else
      driver = Driver.create!(attr)
    end
  end
end
