require 'rails_helper'

RSpec.feature "Signing out" do
  before do
    password = [*(0..9), *('a'..'z'), *('A'..'Z')].sample(8).join
    @user = User.create({email: Faker::Internet.email, password: password})
    @user.confirm
    visit '/'
    click_link 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: password
    click_button 'Log in'
  end

  scenario "signed in out" do
    click_link 'Logout'

    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_link('Login')
    expect(page).to have_link('sign up')
    expect(page).not_to have_link('Log in')
  end
end