require 'rails_helper'

feature 'User views recipes' do

  scenario 'in alphabetical order' do
    user = create(:user)
    create(:recipe, {name: 'Vanilla', user_id: user.id})
    create(:recipe, {name: 'Chocolate', user_id: user.id})
    create(:recipe, {name: 'Strawberry', user_id: user.id})
    sign_in_as user
    visit root_path


    expect(page).to have_content(/Chocolate.*Strawberry.*Vanilla/)
  end
end
