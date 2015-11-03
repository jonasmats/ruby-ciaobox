class Export
  require 'csv'
  class << self
    def admins_to_csv(admins, options = {})
      CSV.generate(options) do |csv|
        columns = ["#", 
          "#{Admin.h :email}", 
          "#{Admin.h :username}", 
          "#{CiaoboxUser::Profile.h :first_name}", 
          "#{CiaoboxUser::Profile.h :last_name}", 
          "#{Admin.h :status}"]
        csv << columns
        admins.select(:id, :email, :status, :username).each.with_index(1) do |admin, index|
          row = []
          row << index
          row << admin.email
          row << admin.username
          row << admin.profile.first_name
          row << admin.profile.last_name
          row << admin.status
          csv << row
        end
      end
    end

    def users_to_csv(users, options = {})
      CSV.generate(options) do |csv|
        columns = ["#", 
          "#{User.h :email}", 
          "#{User.h :username}", 
          "#{User::Profile.h :first_name}", 
          "#{User::Profile.h :last_name}", 
          "#{User.h :status}"]
        csv << columns
        users.select(:id, :email, :status, :username).each.with_index(1) do |user, index|
          row = []
          row << index
          row << user.email
          row << user.username
          row << user.profile.first_name
          row << user.profile.last_name
          row << user.status
          csv << row
        end
      end
    end
  end
end