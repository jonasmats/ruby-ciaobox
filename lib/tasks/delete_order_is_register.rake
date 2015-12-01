namespace :db do
  desc "Fill existing roles with new permissions"

  task delete_order_registering: :environment do
    Order.registering.destroy_all
  end
end