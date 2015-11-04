# == Schema Information
#
# Table name: admins
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  type                   :string
#

class Admin < ActiveRecord::Base
  # require 'csv'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :async
  
  enum status: { un_active: 0, active: 1 }
  delegate :full_name, to: :profile

  #1. associations
  has_one :profile, class_name: ::CiaoboxUser::Profile.name, foreign_key: :admin_id
  # 2. scope
  scope :super_admin, -> {where(type: CiaoboxUser::Super.name)}
  scope :company_admin, -> {where(type: CiaoboxUser::Company.name)}
  scope :employee_admins, -> {where(type: CiaoboxUser::Employee.name)}

  scope :latest, -> {order("created_at DESC")}

  #3. class methods
  # class << self
  #   def to_csv(options = {})
  #     CSV.generate(options) do |csv|
  #       columns = ["#", 
  #         "#{Admin.h :email}", 
  #         "#{CiaoboxUser::Profile.h :username}", 
  #         "#{CiaoboxUser::Profile.h :first_name}", 
  #         "#{CiaoboxUser::Profile.h :last_name}", 
  #         "#{Admin.h :status}"]
  #       csv << columns
  #       all.select(:id, :email, :status).each.with_index(1) do |admin, index|
  #         row = []
  #         row << index
  #         row << admin.email
  #         row << admin.profile.username
  #         row << admin.profile.first_name
  #         row << admin.profile.last_name
  #         row << admin.status
  #         csv << row
  #       end
  #     end
  #   end
  # end
  # 6. instance methods

  def super?
    self.type == CiaoboxUser::Super.name
  end

  def company?
    self.type == CiaoboxUser::Company.name
  end

  def employee?
    self.type == CiaoboxUser::Employee.name
  end

  def self.import(file)
    spreadsheet = Import.open_spreadsheet(file)
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
      user = find_by(email: row["email"]) || new
      user.attributes = row.to_hash.slice(*row.to_hash.keys)
      user.password = '1'
      user.type = CiaoboxUser::Employee.name
      user.save!user

      #save to profile
      profile = CiaoboxUser::Profile.find_by(admin_id: user.id) || user.build_profile
      profile.attributes = profile_row
      profile.save!
    end
  end
end
