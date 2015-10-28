class CiaoboxUser::Profile < ActiveRecord::Base
  # 1. associations
  belongs_to :admin
  # 2. scopes

  # 3. class methods
  def self.table_name_prefix
    'ciaobox_user_'
  end
  # 4. validates
  validates :first_name, :last_name, presence: true

  # 5. callbacks

  # 6. instance methods
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
