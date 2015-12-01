class GiftsCoupon < ActiveRecord::Base
  belongs_to :gift
  belongs_to :custom_gift, class_name: CustomGift.name, foreign_key: :custom_gift_id
end
