class AddAttachmentAvatarToCiaoboxUserProfiles < ActiveRecord::Migration
  def self.up
    change_table :ciaobox_user_profiles do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :ciaobox_user_profiles, :avatar
  end
end
