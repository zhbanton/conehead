User.delete_all
Recipe.delete_all

zack = User.create!(email: 'zack@zack.com', password: 'password')

chocolate = Recipe.create!(name: 'chocolate', note: 'this is good', user_id: zack.id)
