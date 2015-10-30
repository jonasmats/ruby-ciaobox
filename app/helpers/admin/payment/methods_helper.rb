module Admin::Payment::MethodsHelper
  def group_options_to_select_payment_methods
    Payment::Method.all.inject({}) do |options, payment_method|
      (options[payment_method.payment_type] ||= []) << [payment_method.name, payment_method.id]
      options
    end
  end
end
