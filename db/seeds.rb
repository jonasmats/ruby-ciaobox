CiaoboxUser::Super.create(email: "superadmin@gmail.com", password: "1", status: 1)
Admin.first.create_profile(first_name: "An", last_name: "Duong", username: "anduong")

User.create(email: "user_1@gmail.com", password: "1", status: 1)
User.first.create_profile(first_name: "An", last_name: "User", username: "anduonguser")