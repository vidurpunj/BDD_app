require 'rails_helper'

RSpec.feature 'Signup users' do
  before do
    @password = [*('a'..'z'), *('A'..'Z'), *(0..9)].sample(8).join
  end

  scenario "with valid credentials" do
    visit '/'
    click_link 'sign up'
    fill_in "Email", with: Faker::Internet.email
    fill_in "Password", with: @password
    fill_in "Password confirmation", with: @password
    click_button 'Sign up'
  end

  scenario "with invalid credentials" do
    visit '/'
    click_link 'sign up'
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button 'Sign up'

    expect(page).to have_content("errors prohibited this user from being saved")
  end

end