require 'rails_helper'

RSpec.feature do
  before do
    password = [*(0..9), *('a'..'z'), *('A'..'Z')].sample(8).join
    @user = User.create({email: Faker::Internet.email, password: password})
    @user.confirm
    @article1 = Article.create(title: Faker::Book.title, body: Faker::Lorem.paragraph_by_chars(number: 256), user: @user)
    @article2 = Article.create(title: Faker::Book.title, body: Faker::Lorem.paragraph_by_chars(number: 256), user: @user)
  end

  scenario "A user list all the articles" do
    visit('/')

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)

    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end

  scenario "A user have no article" do
    Article.destroy_all
    visit "/"
    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    within("h1#no-article") do
      expect(page).to have_content("No Articles Created")
    end
  end

end
