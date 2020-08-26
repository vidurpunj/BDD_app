require 'rails_helper'

RSpec.feature "Showing an article" do
  before do
    password = [*(0..9), *('a'..'z'), *('A'..'Z')].sample(8).join
    @user = User.create({email: Faker::Internet.email, password: password})
    @user.confirm
    @article1 = Article.create(title: Faker::Book.title, body: Faker::Lorem.paragraph_by_chars(number: 256), user: @user)
    @article2 = Article.create(title: Faker::Book.title, body: Faker::Lorem.paragraph_by_chars(number: 256), user: @user)
  end

  scenario "A user show an article" do
    visit "/"
    click_link(@article1.title)
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(current_path).to eq(article_path(@article1))
  end
end