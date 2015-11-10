config = YAML.load_file Rails.root.join('db/data/ciaobox_user/super.yml')

ActiveRecord::Base.transaction do
  puts "Seed db for Super Admin"
  config.each do |attr|
    id = attr['super_admin'].delete('id')
    super_admin = CiaoboxUser::Super.find_by_id id
    unless super_admin
      super_admin = CiaoboxUser::Super.create!(attr['super_admin'])
      super_admin.profile.update(attr['profile'])
    end
  end
end
