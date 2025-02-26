User.destroy_all
Comment.destroy_all
Project.destroy_all

# You can use this user to login in the frontend
initial_user = { name: 'test', email: 'test@gmail.com', password: 'password' }
User.create(initial_user)
