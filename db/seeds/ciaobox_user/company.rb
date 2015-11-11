config = YAML.load_file Rails.root.join('db/data/ciaobox_user/company.yml')

ActiveRecord::Base.transaction do
  puts "Seed db for Company Admin"
  config.each do |attr|
    id = attr['company_admin'].delete('id')
    company_admin = CiaoboxUser::Company.find_by_id id
    unless company_admin
      company_admin = CiaoboxUser::Company.create!(attr['company_admin'])
      company_admin.profile.update(attr['profile'])
    end
  end
end
