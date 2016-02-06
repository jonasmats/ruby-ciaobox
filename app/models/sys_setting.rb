# == Schema Information
#
# Table name: sys_settings
#
#  id              :integer          not null, primary key
#  currency        :integer
#  payment_method  :integer
#  timezone        :string
#  system_language :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class SysSetting < ActiveRecord::Base
  acts_as_paranoid

  enum sys_currency: {
    CHF: 0,
    EUR: 1
  }

  enum pay_method: {
    CreditCard: 0,
    PayPal: 1,
    Cash: 2,
    Bank: 3
  }

  enum sys_language: {
    en: 0,
    it: 1,
    fr: 2,
    de: 3
  }

  # 1. associations

  # 2. scopes

  # 3. class methods

  # 4. validates
  validates :currency, :payment_method, :timezone, :system_language, presence: true

  # 5. callbacks

  # 6. instance methods
end
