CiaoboxUser::Super.create(email: "superadmin@gmail.com", username: "anduong", password: "1")
Admin.first.create_profile(first_name: "An", last_name: "Duong")

User.create(email: "user_1@gmail.com", username: "anduonguser", password: "1")
User.first.create_profile(first_name: "An", last_name: "User")

Shipping.create!(zip_code: '790000', way: 'standard')
Shipping.create!(zip_code: '880000', way: 'standard')
Shipping.create!(zip_code: '260000', way: 'standard')
Shipping.create!(zip_code: '960000', way: 'fly')
Shipping.create!(zip_code: '220000', way: 'fly')
Shipping.create!(zip_code: '790000', way: 'fly')


require File.dirname(__FILE__) + '/seeds/faqs'