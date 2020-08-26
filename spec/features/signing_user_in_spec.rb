require 'rails_helper'

RSpec.feature 'User Sign in' do
  before do
    @password = [*(0..9),*('a'..'A'),*('A'..'Z')].sample(8).join
    @user = User.create({email: Faker::Internet.email, password: @password})
    @user.confirm
  end

  scenario 'with valid credentials' do
    visit '/'
    click_link 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Login')
    expect(page).not_to have_link('sign up')
  end

end