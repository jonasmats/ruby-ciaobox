config = YAML.load_file Rails.root.join('db/data/user.yml')

ActiveRecord::Base.transaction do
  puts "Seed db for User"
  config.each do |attr|
    id = attr['user'].delete('id')
    user = User.find_by_id id
    unless user
      user = User.create!(attr['user'])
      user.profile.update(attr['profile'])
    end
  end
end
