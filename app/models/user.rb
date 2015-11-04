# == Schema Information
#
# Table name: users
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
#
require 'spreadsheet'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :async,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  
  delegate :full_name, to: :profile
  enum status: { un_active: 0, active: 1 }

  # 1. associations
  has_one :profile, class_name: User::Profile.name, foreign_key: :user_id
  accepts_nested_attributes_for :profile, allow_destroy: true
  # 2. scopes
  scope :latest, -> {order("created_at DESC")}

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.username
      user.status = User.statuses[:active]
    end
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
      user.save!

      #save to profile
      profile = Profile.find_by(user_id: user.id) || user.build_profile
      profile.attributes = profile_row
      profile.save!
    end
  end
end
