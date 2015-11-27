config = YAML.load_file Rails.root.join('db/data/slot_time.yml')

ActiveRecord::Base.transaction do
  puts "Seed db for SlotTime"
  config.each do |attr|
    id = attr.delete('id')
    slot_time = SlotTime.find_by_id id
    if slot_time
      slot_time.update! attr
    else
      slot_time = SlotTime.create!(attr)
    end
  end
end
