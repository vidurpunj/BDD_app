require 'rails_helper'

RSpec.feature "Deleting an Article" do
  before do
    password = [*(0..9), *('a'..'z'), *('A'..'Z')].sample(8).join
    @user = User.create({email: Faker::Internet.email, password: password})
    @user.confirm
    @article = Article.create(title: Faker::Book.title, body: Faker::Lorem.paragraph_by_chars(number: 256), user: @user)
    login_as(@user) ## This method provided by warder through devise
  end

  scenario "Delete Article"do
    visit '/'
    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article was successfully destroyed.")
    expect(current_path).to eq(articles_path)
  end
end