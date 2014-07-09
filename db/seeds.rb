User.delete_all
Recipe.delete_all

zack = User.create!(email: 'zack@zack.com', password: 'password')
jake = User.create!(email: 'jake@jake.com', password: 'password')
