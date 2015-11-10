config = YAML.load_file Rails.root.join('db/data/ciaobox_user/employee.yml')

ActiveRecord::Base.transaction do
  puts "Seed db for Employee"
  config.each do |attr|
    id = attr['employee'].delete('id')
    employee = CiaoboxUser::Employee.find_by_id id
    unless employee
      employee = CiaoboxUser::Employee.create!(attr['employee'])
      employee.profile.update(attr['profile'])
    end
  end
end
