config = YAML.load_file Rails.root.join('db/data/slot_schedule.yml')

ActiveRecord::Base.transaction do
  puts "Seed db for SlotSchedule"
  config.each do |attr|
    id = attr.delete('id')
    slot_schedule = SlotSchedule.find_by_id id
    if slot_schedule
      slot_schedule.update! attr
    else
      slot_schedule = SlotSchedule.create!(attr)
    end
  end
end
