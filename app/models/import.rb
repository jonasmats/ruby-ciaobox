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
      
      # save to user
      user = User.find_by(email: row["email"]) || User.new
      user.attributes = row.to_hash.slice(*row.to_hash.keys)
      user.id = User.last.id + 1
      user.password = '1'
      user.save!
      #save to profile
      profile = ::User::Profile.find_by(user_id: user.id) || user.build_profile
      profile.id = ::User::Profile.last.id + 1
      profile.attributes = profile_row
      profile.save!
    end
  end
end