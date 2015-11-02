# == Schema Information
#
# Table name: payment_infors
#
#  id                :integer          not null, primary key
#  owner_id          :integer          not null
#  owner_type        :string           not null
#  payment_method_id :integer          not null
#  infors            :hstore           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Payment::Infor < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  belongs_to :payment_method, class_name: Payment::Method.name
end
