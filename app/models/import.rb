require 'roo'
require 'spreadsheet'

class Import
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, file_warning: :ignore)
    when ".xls" then Roo::Excel.new(file.path, file_warning: :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, file_warning: :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.import_users(file)
    spreadsheet = self.open_spreadsheet(file)
    header = spreadsheet.row(1).map!(&:downcase)
    email_exists = []
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      row.delete('#')
      profile_row = {}
      row.each do |k,v|
        if k.include?(' ')
          key = k.gsub(' ', '_')
          profile_row[key] = v
          row.delete(k)
        end
      end
      
      if User.find_by(email: row["email"]).present?
        email_exists << row["email"]
      else
      # save to user
        user = User.new
        user.attributes = row.to_hash.slice(*row.to_hash.keys)
        user.id = (User.last.id + 1) if user.id.blank?
        user.password = '1'
        user.save!
        #save to profile
        profile = user.build_profile
        profile.id = (::User::Profile.last.id + 1)
        profile.attributes = profile_row
        profile.save!
      end
    end
    email_exists
  end

  def self.import_admins(file)
    spreadsheet = Import.open_spreadsheet(file)
    header = spreadsheet.row(1).map!(&:downcase)
    email_exists = []
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      row.delete('#')
      profile_row = {}
      row.each do |k,v|
        if k.include?(' ')
          key = k.gsub(' ', '_')
          profile_row[key] = v
          row.delete(k)
        end
      end
      
      if Admin.find_by(email: row["email"]).present?
        email_exists << row["email"]
      else
      # save to admin
        admin = Admin.new
        admin.attributes = row.to_hash.slice(*row.to_hash.keys)
        binding.pry
        admin.id = (Admin.last.id + 1)
        admin.password = '1'
        admin.type = ::CiaoboxUser::Employee.name
        admin.save!

        #save to profile
        profile = admin.build_profile
        profile.id = (::User::Profile.last.id + 1)
        profile.attributes = profile_row
        profile.save!
      end
    end
    email_exists
  end
end